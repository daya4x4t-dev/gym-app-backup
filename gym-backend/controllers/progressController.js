import { supabase } from "../config/supabaseClient.js";
import { sendError, sendSuccess } from "../utils/response.js";

/**
 * ➕ Add progress (weight entry)
 */
export const logProgress = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const { weight, date } = req.body;

    if (weight === undefined || !date) {
      return sendError(res, 400, "weight and date are required");
    }

    const numericWeight = Number(weight);
    if (Number.isNaN(numericWeight)) {
      return sendError(res, 400, "Weight must be numeric");
    }

    const { data, error } = await supabase
      .from("progress")
      .insert({
        user_id: req.user.id,
        weight: numericWeight,
        date,
      })
      .select("*")
      .single();

    if (error) return sendError(res, 400, "Unable to log progress");

    return sendSuccess(res, 201, "Progress logged successfully", data);
  } catch (err) {
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * 📥 Get all progress
 */
export const getProgress = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const { data, error } = await supabase
      .from("progress")
      .select("*")
      .eq("user_id", req.user.id)
      .order("date", { ascending: false });

    if (error) return sendError(res, 400, "Unable to fetch progress");

    return sendSuccess(res, 200, "Progress fetched", data ?? []);
  } catch (err) {
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * 📊 Get latest progress
 */
export const getLatestProgress = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const { data, error } = await supabase
      .from("progress")
      .select("*")
      .eq("user_id", req.user.id)
      .order("date", { ascending: false })
      .limit(1)
      .maybeSingle();

    if (error) return sendError(res, 400, "Unable to fetch latest progress");

    return sendSuccess(res, 200, "Latest progress fetched", data ?? {});
  } catch (err) {
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * 📈 Progress summary
 */
export const getProgressSummary = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const { data, error } = await supabase
      .from("progress")
      .select("weight, date")
      .eq("user_id", req.user.id)
      .order("date", { ascending: true });

    if (error) return sendError(res, 400, "Unable to fetch summary");

    if (!data || data.length === 0) {
      return sendSuccess(res, 200, "Summary fetched", {
        currentWeight: null,
        startingWeight: null,
        totalChange: null,
      });
    }

    const startingWeight = Number(data[0].weight);
    const currentWeight = Number(data[data.length - 1].weight);

    return sendSuccess(res, 200, "Summary fetched", {
      currentWeight,
      startingWeight,
      totalChange: currentWeight - startingWeight,
    });
  } catch (err) {
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * ❌ Delete progress
 */
export const deleteProgress = async (req, res) => {
  try {
    if (!req.user?.id) return sendError(res, 401, "Unauthorized");

    const { id } = req.params;

    const { data, error } = await supabase
      .from("progress")
      .delete()
      .eq("id", id)
      .eq("user_id", req.user.id)
      .select("id")
      .maybeSingle();

    if (error || !data) return sendError(res, 404, "Progress not found");

    return sendSuccess(res, 200, "Progress deleted", data);
  } catch (err) {
    return sendError(res, 500, "Internal server error");
  }
};