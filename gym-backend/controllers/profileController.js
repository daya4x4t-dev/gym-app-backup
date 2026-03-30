import { supabase } from "../config/supabaseClient.js";
import { sendError, sendSuccess } from "../utils/response.js";
import { profileWritableFields } from "../models/User.js";

const goalValues = ["Lose fat", "Gain muscle", "Maintain"];

const toNumberOrNull = (value) => {
  if (value === null || value === undefined || value === "") return null;
  const parsed = Number(value);
  return Number.isFinite(parsed) ? parsed : null;
};

const calculateBmi = (weightKg, heightCm) => {
  if (!weightKg || !heightCm) return null;
  const meters = heightCm / 100;
  if (meters <= 0) return null;
  return Number((weightKg / (meters * meters)).toFixed(2));
};

const mapDbProfileToApi = (record) => {
  const height = toNumberOrNull(record.height);
  const weight = toNumberOrNull(record.weight);
  return {
    id: record.id,
    name: record.name ?? "",
    email: record.email ?? "",
    phone: record.phone ?? "",
    profileImage: record.profile_image ?? "",
    age: toNumberOrNull(record.age),
    gender: record.gender ?? "",
    height,
    weight,
    goal: record.goal ?? "Maintain",
    fitnessLevel: record.fitness_level ?? "",
    bmi: calculateBmi(weight, height),
    subscriptionPlan: record.subscription_plan ?? "Free",
    subscriptionExpiry: record.subscription_expiry,
    workoutStreak: toNumberOrNull(record.workout_streak) ?? 0,
    caloriesBurned: toNumberOrNull(record.calories_burned) ?? 0,
    createdAt: record.created_at,
  };
};

const sanitizeUpdatePayload = (body) => {
  const payload = {};

  for (const field of profileWritableFields) {
    if (!(field in body)) continue;

    const value = body[field];
    if (field === "goal" && value && !goalValues.includes(String(value))) {
      continue;
    }

    payload[field] = value;
  }

  const height = toNumberOrNull(payload.height);
  const weight = toNumberOrNull(payload.weight);
  if (height !== null) payload.height = height;
  if (weight !== null) payload.weight = weight;

  if ("profileImage" in payload) {
    payload.profile_image = payload.profileImage;
    delete payload.profileImage;
  }

  if ("fitnessLevel" in payload) {
    payload.fitness_level = payload.fitnessLevel;
    delete payload.fitnessLevel;
  }

  if ("subscriptionPlan" in payload) {
    payload.subscription_plan = payload.subscriptionPlan;
    delete payload.subscriptionPlan;
  }

  if ("subscriptionExpiry" in payload) {
    payload.subscription_expiry = payload.subscriptionExpiry;
    delete payload.subscriptionExpiry;
  }

  if ("workoutStreak" in payload) {
    payload.workout_streak = toNumberOrNull(payload.workoutStreak) ?? 0;
    delete payload.workoutStreak;
  }

  if ("caloriesBurned" in payload) {
    payload.calories_burned = toNumberOrNull(payload.caloriesBurned) ?? 0;
    delete payload.caloriesBurned;
  }

  payload.bmi = calculateBmi(
    toNumberOrNull(payload.weight),
    toNumberOrNull(payload.height)
  );

  return payload;
};

const profileSelect = `
  id,
  name,
  email,
  phone,
  profile_image,
  age,
  gender,
  height,
  weight,
  goal,
  fitness_level,
  bmi,
  subscription_plan,
  subscription_expiry,
  workout_streak,
  calories_burned,
  created_at
`;

export const getUserProfile = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const { data, error } = await supabase
      .from("profiles")
      .select(profileSelect)
      .eq("id", req.user.id)
      .maybeSingle();

    if (error) return sendError(res, 400, "Unable to fetch profile");
    if (!data) return sendSuccess(res, 200, "Profile fetched", {});

    return sendSuccess(res, 200, "Profile fetched", mapDbProfileToApi(data));
  } catch {
    return sendError(res, 500, "Internal server error");
  }
};

export const updateUserProfile = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const payload = sanitizeUpdatePayload(req.body);

    if (!Object.keys(payload).length) {
      return sendError(res, 400, "No valid fields provided");
    }

    const { data, error } = await supabase
      .from("profiles")
      .upsert({ id: req.user.id, ...payload }, { onConflict: "id" })
      .select(profileSelect)
      .maybeSingle();

    if (error) return sendError(res, 400, "Unable to update profile");

    return sendSuccess(
      res,
      200,
      "Profile updated successfully",
      mapDbProfileToApi(data ?? { id: req.user.id, ...payload })
    );
  } catch {
    return sendError(res, 500, "Internal server error");
  }
};

export const getUserProgress = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const { data: profile, error: profileError } = await supabase
      .from("profiles")
      .select("workout_streak, calories_burned")
      .eq("id", req.user.id)
      .maybeSingle();

    if (profileError) return sendError(res, 400, "Unable to fetch profile progress");

    const { data: weightHistory, error: historyError } = await supabase
      .from("progress")
      .select("weight, date")
      .eq("user_id", req.user.id)
      .order("date", { ascending: true });

    if (historyError) return sendError(res, 400, "Unable to fetch weight history");

    return sendSuccess(res, 200, "Progress fetched", {
      workoutStreak: Number(profile?.workout_streak ?? 0),
      caloriesBurned: Number(profile?.calories_burned ?? 0),
      weightHistory: weightHistory ?? [],
    });
  } catch {
    return sendError(res, 500, "Internal server error");
  }
};

export const getMyProfile = getUserProfile;
export const updateMyProfile = updateUserProfile;
