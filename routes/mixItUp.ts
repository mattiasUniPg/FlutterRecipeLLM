import express from "express"
import { Configuration, OpenAIApi } from "openai"
import Recipe from "../models/Recipe"
import { authenticateToken } from "../middleware/auth"

const router = express.Router()

const configuration = new Configuration({
  apiKey: process.env.OPENAI_API_KEY,
})
const openai = new OpenAIApi(configuration)

router.post("/", authenticateToken, async (req, res) => {
  try {
    const recipes = await Recipe.find().limit(10)
    const recipePrompt = recipes.map((recipe) => `${recipe.title}: ${recipe.ingredients.join(", ")}`).join("\n")

    const prompt = `Based on these recipes:\n${recipePrompt}\n\nCreate a new, creative recipe that combines elements from the above recipes. Include a title, ingredients list, and instructions.`

    const completion = await openai.createCompletion({
      model: "text-davinci-002",
      prompt: prompt,
      max_tokens: 500,
    })

    const generatedRecipe = completion.data.choices[0].text?.trim()
    res.json({ generatedRecipe })
  } catch (error) {
    res.status(500).json({ message: "Error generating mixed recipe", error })
  }
})

export default router