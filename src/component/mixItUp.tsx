"use client"

import { useState } from "react"
import { Container, Typography, Button, Box, Paper } from "@mui/material"
import axios from "axios"

const MixItUp = () => {
  const [generatedRecipe, setGeneratedRecipe] = useState("")
  const [loading, setLoading] = useState(false)

  const handleMixItUp = async () => {
    setLoading(true)
    try {
      const response = await axios.post(
        "http://localhost:5000/api/mix-it-up",
        {},
        {
          headers: { Authorization: `Bearer ${localStorage.getItem("token")}` },
        },
      )
      setGeneratedRecipe(response.data.generatedRecipe)
    } catch (error) {
      console.error("Error generating mixed recipe:", error)
    } finally {
      setLoading(false)
    }
  }

  return (
    <Container>
      <Typography variant="h4" component="h1" gutterBottom>
        Mix It Up!
      </Typography>
      <Button variant="contained" color="primary" onClick={handleMixItUp} disabled={loading}>
        {loading ? "Generating..." : "Generate Creative Recipe"}
      </Button>
      {generatedRecipe && (
        <Box mt={4}>
          <Paper elevation={3} sx={{ p: 3 }}>
            <Typography variant="h6" gutterBottom>
              Generated Recipe:
            </Typography>
            <Typography variant="body1" component="pre" sx={{ whiteSpace: "pre-wrap" }}>
              {generatedRecipe}
            </Typography>
          </Paper>
        </Box>
      )}
    </Container>
  )
}

export default MixItUp