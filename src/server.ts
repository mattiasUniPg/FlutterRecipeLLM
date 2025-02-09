import express from "express"
import mongoose from "mongoose"
import cors from "cors"
import dotenv from "dotenv"
import authRoutes from "./routes/auth"
import recipeRoutes from "./routes/recipes"
import mixItUpRoutes from "./routes/mixItUp"

dotenv.config()

const app = express()
const PORT = process.env.PORT || 5000

app.use(cors())
app.use(express.json())

mongoose
  .connect(process.env.MONGODB_URI as string)
  .then(() => console.log("Connected to MongoDB"))
  .catch((error) => console.error("MongoDB connection error:", error))

app.use("/api/auth", authRoutes)
app.use("/api/recipes", recipeRoutes)
app.use("/api/mix-it-up", mixItUpRoutes)

app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`)
})

