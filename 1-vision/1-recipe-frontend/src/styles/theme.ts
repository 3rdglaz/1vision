import { Nunito } from "next/font/google";
import { createTheme } from "@mui/material/styles";
import { red } from "@mui/material/colors";

export const nunito = Nunito({
  weight: ["300", "400", "500", "700"],
  subsets: ["latin"],
  display: "swap",
  fallback: ["Helvetica", "Arial", "sans-serif"],
});

// Create a theme instance.
const theme = createTheme({
  palette: {
    primary: {
      main: "#FFFFFF",
    },
    secondary: {
      main: "#B2131E",
      dark: "#760e15",
    },
    error: {
      main: red.A400,
    },
  },
  typography: {
    fontFamily: nunito.style.fontFamily,
  },
});

export default theme;
