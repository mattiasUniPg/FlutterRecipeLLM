import mongoose, { type Document, Schema } from "mongoose"

export interface IRecipe extends Document {
  title: string
  ingredients: string[]
  instructions: string
  userId: mongoose.Types.ObjectId
  createdAt: Date
  updatedAt: Date
}

const RecipeSchema: Schema = new Schema(
  {
    title: { type: String, required: true },
    ingredients: { type: [String], required: true },
    instructions: { type: String, required: true },
    userId: { type: mongoose.Schema.Types.ObjectId, ref: "User", required: true },
  },
  { timestamps: true },
)

export default mongoose.model<IRecipe>("Recipe", RecipeSchema)