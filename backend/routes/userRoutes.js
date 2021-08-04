import express from 'express';
const router = express.Router();
import {
  authUser,
  createUser,
  getUserProfile,
  getUsers,
  updateUserProfile,
} from '../controllers/userController.js';
import { isAdmin, protect } from '../middleware/authMiddleware.js';

router.route('/').post(createUser).get(protect, isAdmin, getUsers);
router.post('/login', authUser);
router
  .route('/profile')
  .get(protect, getUserProfile)
  .put(protect, updateUserProfile);

export default router;
