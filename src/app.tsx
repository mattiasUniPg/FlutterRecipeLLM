import { BrowserRouter as Router, Route, Switch } from "react-router-dom"
import { ThemeProvider, createTheme } from "@mui/material/styles"
import CssBaseline from "@mui/material/CssBaseline"
import Login from "./components/Login"
import Register from "./components/Register"
import Home from "./components/Home"
import PublicRecipes from "./components/PublicRecipes"
import MixItUp from "./components/MixItUp"
import PrivateRoute from "./components/PrivateRoute"

const theme = createTheme({
  palette: {
    primary: {
      main: "#4caf50",
    },
    secondary: {
      main: "#ff9800",
    },
  },
})

function App() {
  return (
    <ThemeProvider theme={theme}>
      <CssBaseline />
      <Router>
        <Switch>
          <Route exact path="/" component={Login} />
          <Route path="/register" component={Register} />
          <PrivateRoute path="/home" component={Home} />
          <Route path="/public" component={PublicRecipes} />
          <PrivateRoute path="/mix-it-up" component={MixItUp} />
        </Switch>
      </Router>
    </ThemeProvider>
  )
}

export default App