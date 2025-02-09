"use client"

import { useState, useEffect } from "react"
import { Container, Typography, List, ListItem, ListItemText } from "@mui/material"
import axios from "axios"

interface Recipe {
  _id: string
  title: string
  ingredients: string[]
  instructions: string
  userId: {
    username: string
  }
}

const PublicRecipes = () => {
  const [recipes, setRecipes] = useState<Recipe[]>([])

  useEffect(() => {
    fetchPublicRecipes()
  }, [])

  const fetchPublicRecipes = async () => {
    try {
      const response = await axios.get("http://localhost:5000/api/recipes/public")
      setRecipes(response.data)
    } catch (error) {
      console.error("Error fetching public recipes:", error)
    }
  }

  return (
    <Container>
      <Typography variant="h4" component="h1" gutterBottom>
        Public Recipes
      </Typography>
      <List>
        {recipes.map((recipe) => (
          <ListItem key={recipe._id}>
            <ListItemText
              primary={recipe.title}
              secondary={`By: ${recipe.userId.username} | Ingredients: ${recipe.ingredients.join(", ")}`}
            />
          </ListItem>
        ))}
      </List>
    </Container>
  )
}

export default PublicRecipes