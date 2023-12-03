import { TextField, Typography } from "@mui/material";
import { styled } from "@mui/system";

export const StyledTextField = styled(TextField)({
  fontStyle: "normal",
  fontWeight: 600,
  fontSize: "16px",
  lineHeight: "24px",
  letterSpacing: "0.5px",
  marginBottom: 16,

  ".MuiInputBase-root": {
    height: "56px",
  },
});

export const StyledTitle = styled(Typography)({
  fontStyle: "normal",
  fontWeight: 700,
  fontSize: "32px",
  lineHeight: "44px",
  margin: 0,
});

export const StyledText = styled(Typography)({
  fontStyle: "normal",
  fontWeight: 400,
  fontSize: "16px",
  lineHeight: "20px",
  margin: "0 16px 0 0",
});
