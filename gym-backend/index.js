import express from "express";
import cors from "cors";
import dotenv from "dotenv";
import helmet from "helmet";
import morgan from "morgan";
import rateLimit from "express-rate-limit";

// Routes
import profileRoutes from "./routes/profileRoutes.js";
import authRoutes from "./routes/auth.js";
import workoutRoutes from "./routes/workouts.js";
import progressRoutes from "./routes/progress.js";
import statsRoutes from "./routes/stats.js";
import exerciseRoutes from "./routes/exercises.js";
import userRoutes from "./routes/user.js";

dotenv.config();

const app = express();
const PORT = process.env.PORT || 8000;

// =======================
// SECURITY
// =======================
app.use(helmet());

// =======================
// CORS (FIXED FOR MOBILE)
// =======================
app.use(cors()); // ✅ allow all origins (fixes mobile issue)

// =======================
// RATE LIMIT
// =======================
app.use(
  rateLimit({
    windowMs: 15 * 60 * 1000,
    max: 100,
  })
);

// =======================
// BODY PARSER
// =======================
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// =======================
// LOGGER
// =======================
app.use(morgan("dev"));

// =======================
// DEBUG LOGS
// =======================
app.use((req, res, next) => {
  console.log(`📩 ${req.method} ${req.originalUrl}`);
  next();
});

// =======================
// HEALTH CHECK (IMPORTANT)
// =======================
app.get("/", (req, res) => {
  res.send("🚀 API is running");
});

app.get("/health", (req, res) => {
  res.json({
    success: true,
    message: "Server is healthy",
  });
});

// =======================
// ROUTES
// =======================
app.use("/api/auth", authRoutes);
app.use("/api/profile", profileRoutes);
app.use("/api/workouts", workoutRoutes);
app.use("/api/progress", progressRoutes);
app.use("/api/stats", statsRoutes);
app.use("/api/exercises", exerciseRoutes);
app.use("/api/user", userRoutes);

// =======================
// 404 HANDLER
// =======================
app.use((req, res) => {
  res.status(404).json({
    success: false,
    message: `Route not found: ${req.method} ${req.originalUrl}`,
  });
});

// =======================
// ERROR HANDLER
// =======================
app.use((err, req, res, next) => {
  console.error("🔥 ERROR:", err.message);

  res.status(500).json({
    success: false,
    message: err.message || "Internal server error",
  });
});

// =======================
// START SERVER
// =======================
app.listen(PORT, "0.0.0.0", () => {
  console.log(`🚀 Server running at:`);
  console.log(`👉 Local:   http://localhost:${PORT}`);
  console.log(`👉 Network: http://192.168.1.9:${PORT}`);
});