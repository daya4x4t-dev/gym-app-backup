import express from "express";
import authMiddleware from "../middleware/authMiddleware.js";
import {
  getMyProfile,
  updateMyProfile,
} from "../controllers/profileController.js";

const router = express.Router();

// 🔐 Protect all routes
router.use(authMiddleware);

// 👤 Get logged-in user profile
router.get("/", getMyProfile);

// ✏️ Update profile
router.put("/", updateMyProfile);

export default router;