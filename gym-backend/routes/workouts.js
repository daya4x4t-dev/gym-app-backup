import express from "express";
import authMiddleware from "../middleware/authMiddleware.js";
import {
  createWorkout,
  deleteWorkout,
  getWorkoutById,
  getWorkouts,
  updateWorkout,
} from "../controllers/workoutController.js";

const router = express.Router();

// 🔐 Protect all routes
router.use(authMiddleware);

// ➕ Create workout
router.post("/", createWorkout);

// 📥 Get all workouts (for logged-in user)
router.get("/", getWorkouts);

// 🔍 Get single workout
router.get("/:id", getWorkoutById);

// ✏️ Update workout
router.put("/:id", updateWorkout);

// ❌ Delete workout
router.delete("/:id", deleteWorkout);

export default router;