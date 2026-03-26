import express from "express";
import authMiddleware from "../middleware/authMiddleware.js";
import {
  getUserProfile,
  updateUserProfile,
  getUserProgress,
} from "../controllers/profileController.js";

const router = express.Router();

router.use(authMiddleware);
router.get("/profile", getUserProfile);
router.put("/profile", updateUserProfile);
router.get("/progress", getUserProgress);

export default router;
