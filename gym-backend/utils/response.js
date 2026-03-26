/**
 * ✅ Send success response
 */
export const sendSuccess = (res, statusCode, message, data = {}) => {
  return res.status(statusCode).json({
    success: true,
    message,
    data: data ?? {},
  });
};

/**
 * ❌ Send error response
 */
export const sendError = (res, statusCode, message, error = null) => {
  return res.status(statusCode).json({
    success: false,
    message,
    data: {},
    ...(error && { error }), // optional debug info
  });
};

/**
 * 🔍 Validate UUID
 */
export const isUuid = (value) => {
  return /^[0-9a-f]{8}-[0-9a-f]{4}-[1-5][0-9a-f]{3}-[89ab][0-9a-f]{3}-[0-9a-f]{12}$/i.test(
    String(value || "")
  );
};