"use client"

import type React from "react"
import { useState, useEffect } from "react"
import {
  Container,
  Typography,
  Box,
  Button,
  TextField,
  List,
  ListItem,
  ListItemText,
  ListItemSecondaryAction,
  IconButton,
} from "@mui/material"
import DeleteIcon from "@mui/icons-material/Delete"
import axios from "axios"

interface Recipe {
  _id: string
  title: string
  ingredients: string[]
  instructions: string
}

const Home = () => {
  const [recipes, setRecipes] = useState<Recipe[]>([])
  const [title, setTitle] = useState("")
  const [ingredients, setIngredients] = useState("")
  const [instructions, setInstructions] = useState("")

  useEffect(() => {
    fetchRecipes()
  }, [])

  const fetchRecipes = async () => {
    try {
      const response = await axios.get("http://localhost:5000/api/recipes/user", {
        headers: { Authorization: `Bearer ${localStorage.getItem("token")}` },
      })
      setRecipes(response.data)
    } catch (error) {
      console.error("Error fetching recipes:", error)
    }
  }

  const handleAddRecipe = async (e: React.FormEvent) => {
    e.preventDefault()
    try {
      await axios.post(
        "http://localhost:5000/api/recipes",
        {
          title,
          ingredients: ingredients.split(",").map((item) => item.trim()),
          instructions,
        },
        {
          headers: { Authorization: `Bearer ${localStorage.getItem("token")}` },
        },
      )
      setTitle("")
      setIngredients("")
      setInstructions("")
      fetchRecipes()
    } catch (error) {
      console.error("Error adding recipe:", error)
    }
  }

  const handleDeleteRecipe = async (id: string) => {
    try {
      await axios.delete(`http://localhost:5000/api/recipes/${id}`, {
        headers: { Authorization: `Bearer ${localStorage.getItem("token")}` },
      })
      fetchRecipes()
    } catch (error) {
      console.error("Error deleting recipe:", error)
    }
  }

  return (
    <Container>
      <Typography variant="h4" component="h1" gutterBottom>
        My Recipes
      </Typography>
      <Box component="form" onSubmit={handleAddRecipe} sx={{ mb: 4 }}>
        <TextField
          fullWidth
          label="Recipe Title"
          value={title}
          onChange={(e) => setTitle(e.target.value)}
          margin="normal"
          required
        />
        <TextField
          fullWidth
          label="Ingredients (comma-separated)"
          value={ingredients}
          onChange={(e) => setIngredients(e.target.value)}
          margin="normal"
          required
        />
        <TextField
          fullWidth
          label="Instructions"
          value={instructions}
          onChange={(e) => setInstructions(e.target.value)}
          margin="normal"
          required
          multiline
          rows={4}
        />
        <Button type="submit" variant="contained" color="primary" sx={{ mt: 2 }}>
          Add Recipe
        </Button>
      </Box>
      <List>
        {recipes.map((recipe) => (
          <ListItem key={recipe._id}>
            <ListItemText primary={recipe.title} secondary={`Ingredients: ${recipe.ingredients.join(", ")}`} />
            <ListItemSecondaryAction>
              <IconButton edge="end" aria-label="delete" onClick={() => handleDeleteRecipe(recipe._id)}>
                <DeleteIcon />
              </IconButton>
            </ListItemSecondaryAction>
          </ListItem>
        ))}
      </List>
    </Container>
  )
}

export default Home