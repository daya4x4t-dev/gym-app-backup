import express from "express";
import authMiddleware from "../middleware/authMiddleware.js";
import {
  logProgress,
  getProgress,
  getLatestProgress,
  deleteProgress,
} from "../controllers/progressController.js";

const router = express.Router();

// 🔐 Protect all routes
router.use(authMiddleware);

// ➕ Add progress (weight log)
router.post("/", logProgress);

// 📥 Get all progress
router.get("/", getProgress);

// 📊 Get latest progress
router.get("/latest", getLatestProgress);

// ❌ Delete progress
router.delete("/:id", deleteProgress);

export default router;