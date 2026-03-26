import { supabase } from "../config/supabaseClient.js";
import { isUuid, sendError, sendSuccess } from "../utils/response.js";

/**
 * ➕ Create workout
 */
export const createWorkout = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const { title, exercises, duration } = req.body;

    if (!title || !Array.isArray(exercises)) {
      return sendError(res, 400, "Title and exercises array are required");
    }

    const { data, error } = await supabase
      .from("workouts")
      .insert({
        user_id: req.user.id,
        title: String(title).trim(),
        exercises,
        duration: duration ?? null,
      })
      .select("*")
      .single();

    if (error) return sendError(res, 400, "Unable to create workout");

    return sendSuccess(res, 201, "Workout created successfully", data);
  } catch (err) {
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * 📥 Get workouts (with pagination)
 */
export const getWorkouts = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const page = Math.max(1, Number(req.query.page) || 1);
    const limit = Math.min(50, Number(req.query.limit) || 10);

    const from = (page - 1) * limit;
    const to = from + limit - 1;

    const { data, error, count } = await supabase
      .from("workouts")
      .select("*", { count: "exact" })
      .eq("user_id", req.user.id)
      .order("created_at", { ascending: false })
      .range(from, to);

    if (error) return sendError(res, 400, "Unable to fetch workouts");

    return sendSuccess(res, 200, "Workouts fetched", {
      items: data ?? [],
      pagination: { page, limit, total: count || 0 },
    });
  } catch (err) {
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * 🔍 Get single workout
 */
export const getWorkoutById = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const { id } = req.params;
    if (!isUuid(id)) return sendError(res, 400, "Invalid workout id");

    const { data, error } = await supabase
      .from("workouts")
      .select("*")
      .eq("id", id)
      .eq("user_id", req.user.id)
      .single();

    if (error || !data) return sendError(res, 404, "Workout not found");

    return sendSuccess(res, 200, "Workout fetched", data);
  } catch (err) {
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * ✏️ Update workout
 */
export const updateWorkout = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const { id } = req.params;
    if (!isUuid(id)) return sendError(res, 400, "Invalid workout id");

    const { title, exercises, duration } = req.body;

    const payload = {};
    if (title !== undefined) payload.title = String(title).trim();
    if (exercises !== undefined) {
      if (!Array.isArray(exercises)) {
        return sendError(res, 400, "Exercises must be an array");
      }
      payload.exercises = exercises;
    }
    if (duration !== undefined) payload.duration = duration;

    if (!Object.keys(payload).length) {
      return sendError(res, 400, "No valid fields to update");
    }

    const { data, error } = await supabase
      .from("workouts")
      .update(payload)
      .eq("id", id)
      .eq("user_id", req.user.id)
      .select("*")
      .single();

    if (error || !data) return sendError(res, 404, "Workout not found");

    return sendSuccess(res, 200, "Workout updated", data);
  } catch (err) {
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * ❌ Delete workout
 */
export const deleteWorkout = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const { id } = req.params;
    if (!isUuid(id)) return sendError(res, 400, "Invalid workout id");

    const { data, error } = await supabase
      .from("workouts")
      .delete()
      .eq("id", id)
      .eq("user_id", req.user.id)
      .select("id")
      .maybeSingle();

    if (error || !data) return sendError(res, 404, "Workout not found");

    return sendSuccess(res, 200, "Workout deleted", data);
  } catch (err) {
    return sendError(res, 500, "Internal server error");
  }
};