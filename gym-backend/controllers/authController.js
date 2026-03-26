import crypto from "node:crypto";
import { supabase } from "../config/supabaseClient.js";
import { sendError, sendSuccess } from "../utils/response.js";

const safeAuthMessage = "Authentication request failed";

export const signup = async (req, res) => {
  try {
    const { email, password, name } = req.body;

    if (!email || !password || !name) {
      return sendError(res, 400, "Email, password and name are required");
    }

    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: { name },
      },
    });

    if (error) return sendError(res, 400, error.message);

    const user = data.user;

    await supabase.from("profiles").upsert(
      {
        id: user.id,
        name,
        email,
      },
      { onConflict: "id" }
    );

    return sendSuccess(res, 201, "Signup successful", data);
  } catch {
    return sendError(res, 500, "Internal server error");
  }
};

export const login = async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return sendError(res, 400, "Email and password are required");
    }

    const { data, error } = await supabase.auth.signInWithPassword({
      email: String(email).trim().toLowerCase(),
      password: String(password),
    });

    if (error || !data.session) {
      return sendError(res, 401, "Invalid email or password");
    }

    return sendSuccess(res, 200, "Login successful", {
      token: data.session.access_token,
      refreshToken: data.session.refresh_token,
      user: data.user,
    });
  } catch {
    return sendError(res, 500, "Internal server error");
  }
};

export const forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;

    if (!email) return sendError(res, 400, "Email is required");

    const { data: authData, error: userError } = await supabase.auth.admin.listUsers();
    if (userError) return sendError(res, 500, "Unable to process reset request");

    const matchedUser = authData.users.find(
      (user) => String(user.email || "").toLowerCase() === String(email).toLowerCase()
    );

    if (!matchedUser) {
      return sendSuccess(res, 200, "If this email exists, a reset link will be sent");
    }

    const token = crypto.randomBytes(32).toString("hex");
    const hashedToken = crypto.createHash("sha256").update(token).digest("hex");
    const expiry = new Date(Date.now() + 1000 * 60 * 30).toISOString();

    const { error: profileError } = await supabase
      .from("profiles")
      .upsert(
        {
          id: matchedUser.id,
          email,
          reset_password_token: hashedToken,
          reset_password_expiry: expiry,
        },
        { onConflict: "id" }
      );

    if (profileError) return sendError(res, 500, "Unable to save reset token");

    return sendSuccess(res, 200, "Password reset token generated", {
      resetToken: token,
      expiresAt: expiry,
    });
  } catch {
    return sendError(res, 500, "Internal server error");
  }
};

export const verifyOtp = async (req, res) => {
  try {
    const { email, token } = req.body;

    if (!email || !token) {
      return sendError(res, 400, "Email and token are required");
    }

    const { data, error } = await supabase.auth.verifyOtp({
      email,
      token,
      type: "email",
    });

    if (error) return sendError(res, 400, safeAuthMessage);

    return sendSuccess(res, 200, "OTP verified", data);
  } catch {
    return sendError(res, 500, "Internal server error");
  }
};

export const resetPassword = async (req, res) => {
  try {
    const { token, password, confirmPassword } = req.body;

    if (!token || !password || !confirmPassword) {
      return sendError(res, 400, "token, password, and confirmPassword are required");
    }

    if (String(password).length < 6) {
      return sendError(res, 400, "Password must be at least 6 characters");
    }

    if (password !== confirmPassword) {
      return sendError(res, 400, "Passwords do not match");
    }

    const hashedToken = crypto.createHash("sha256").update(token).digest("hex");

    const { data: profile, error: profileError } = await supabase
      .from("profiles")
      .select("id, reset_password_expiry")
      .eq("reset_password_token", hashedToken)
      .maybeSingle();

    if (profileError || !profile) return sendError(res, 400, "Invalid reset token");

    if (new Date(profile.reset_password_expiry).getTime() < Date.now()) {
      return sendError(res, 400, "Reset token expired");
    }

    const hashedPassword = crypto.scryptSync(password, "gym-app-salt", 64).toString("hex");

    const { error: authError } = await supabase.auth.admin.updateUserById(profile.id, {
      password,
      user_metadata: {
        passwordLastResetAt: new Date().toISOString(),
      },
    });

    if (authError) return sendError(res, 400, safeAuthMessage);

    const { error: updateError } = await supabase
      .from("profiles")
      .update({
        password_hash: hashedPassword,
        reset_password_token: null,
        reset_password_expiry: null,
      })
      .eq("id", profile.id);

    if (updateError) return sendError(res, 400, "Password updated but cleanup failed");

    return sendSuccess(res, 200, "Password updated successfully");
  } catch {
    return sendError(res, 500, "Internal server error");
  }
};
