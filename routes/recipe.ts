import express from "express"
import Recipe from "../models/Recipe"
import { authenticateToken } from "../middleware/auth"

const router = express.Router()

router.post("/", authenticateToken, async (req, res) => {
  try {
    const { title, ingredients, instructions } = req.body
    const recipe = new Recipe({
      title,
      ingredients,
      instructions,
      userId: req.user.userId,
    })
    await recipe.save()
    res.status(201).json(recipe)
  } catch (error) {
    res.status(500).json({ message: "Error creating recipe", error })
  }
})

router.get("/user", authenticateToken, async (req, res) => {
  try {
    const recipes = await Recipe.find({ userId: req.user.userId })
    res.json(recipes)
  } catch (error) {
    res.status(500).json({ message: "Error fetching recipes", error })
  }
})

router.get("/public", async (req, res) => {
  try {
    const recipes = await Recipe.find().populate("userId", "username")
    res.json(recipes)
  } catch (error) {
    res.status(500).json({ message: "Error fetching public recipes", error })
  }
})

router.delete("/:id", authenticateToken, async (req, res) => {
  try {
    const recipe = await Recipe.findOneAndDelete({ _id: req.params.id, userId: req.user.userId })
    if (!recipe) {
      return res.status(404).json({ message: "Recipe not found or unauthorized" })
    }
    res.json({ message: "Recipe deleted successfully" })
  } catch (error) {
    res.status(500).json({ message: "Error deleting recipe", error })
  }
})

export default router