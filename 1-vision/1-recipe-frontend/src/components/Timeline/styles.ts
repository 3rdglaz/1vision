import { Tabs, TextField } from "@mui/material";
import { styled } from "@mui/system";

const StyledTextField = styled(TextField)({
  fontStyle: "normal",
  fontWeight: 600,
  fontSize: "16px",
  lineHeight: "24px",
  letterSpacing: "0.5px",

  ".MuiInputBase-root": {
    borderRadius: "28px",
    height: "40px",
    paddingLeft: "18px",
  },

  ".MuiFormLabel-root": {
    top: "-6.5px",
    left: "",
  },
});

const StyledTabs = styled(Tabs)({
  ".MuiButtonBase-root": {
    fontFamily: "Roboto",
    fontStyle: "normal",
    fontWeight: 500,
    fontSize: "14px",
    lineHeight: "20px",
    letterSpacing: "0.1px",
    textTransform: "none",
  },
});

export { StyledTextField, StyledTabs };
