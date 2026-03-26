import { supabase } from "../config/supabaseClient.js";
import { sendError, sendSuccess } from "../utils/response.js";

const safeAuthMessage = "Authentication request failed";

/**
 * 🔐 SIGNUP
 */
export const signup = async (req, res) => {
  try {
    const { email, password, name } = req.body;

    console.log("BODY:", req.body);

    if (!email || !password || !name) {
      return sendError(res, 400, "Email, password and name are required");
    }

    // ✅ Create user in Supabase Auth
    const { data, error } = await supabase.auth.signUp({
      email,
      password,
      options: {
        data: { name },
      },
    });

    if (error) {
      console.log("SUPABASE ERROR:", error);
      return sendError(res, 400, error.message);
    }

    const user = data.user;

    // ✅ Insert into profiles table
    const { error: profileError } = await supabase
      .from("profiles")
      .insert([
        {
          id: user.id,
          full_name: name,
        },
      ]);

    if (profileError) {
      console.log("PROFILE INSERT ERROR:", profileError);
      // Not blocking signup — just logging
    }

    return sendSuccess(res, 201, "Signup successful", data);
  } catch (err) {
    console.log("SERVER ERROR:", err);
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * 🔐 LOGIN
 */
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
      user: data.user,
    });
  } catch (err) {
    console.log("LOGIN ERROR:", err);
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * 📧 FORGOT PASSWORD
 */
export const forgotPassword = async (req, res) => {
  try {
    const { email } = req.body;

    if (!email) {
      return sendError(res, 400, "Email is required");
    }

    const redirectTo = process.env.PASSWORD_RESET_URL;

    if (!redirectTo) {
      return sendError(res, 500, "Reset URL not configured");
    }

    const { error } = await supabase.auth.resetPasswordForEmail(email, {
      redirectTo,
    });

    if (error) {
      console.log("FORGOT PASSWORD ERROR:", error);
      return sendError(res, 400, safeAuthMessage);
    }

    return sendSuccess(res, 200, "Password reset email sent");
  } catch (err) {
    console.log("FORGOT ERROR:", err);
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * 🔢 VERIFY OTP
 */
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

    if (error) {
      console.log("OTP ERROR:", error);
      return sendError(res, 400, safeAuthMessage);
    }

    return sendSuccess(res, 200, "OTP verified", data);
  } catch (err) {
    console.log("VERIFY ERROR:", err);
    return sendError(res, 500, "Internal server error");
  }
};

/**
 * 🔒 RESET PASSWORD
 */
export const resetPassword = async (req, res) => {
  try {
    const { password, accessToken } = req.body;

    if (!password || !accessToken) {
      return sendError(res, 400, "Password and token required");
    }

    // Set session
    const { error: sessionError } = await supabase.auth.setSession({
      access_token: accessToken,
      refresh_token: accessToken,
    });

    if (sessionError) {
      return sendError(res, 401, "Invalid token");
    }

    // Update password
    const { error } = await supabase.auth.updateUser({
      password,
    });

    if (error) {
      console.log("RESET ERROR:", error);
      return sendError(res, 400, safeAuthMessage);
    }

    return sendSuccess(res, 200, "Password updated successfully");
  } catch (err) {
    console.log("RESET SERVER ERROR:", err);
    return sendError(res, 500, "Internal server error");
  }
};