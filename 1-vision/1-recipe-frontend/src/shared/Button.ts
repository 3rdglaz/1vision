import { Button, ButtonProps } from "@mui/material";
import { styled } from "@mui/system";

type StyledButtonProps = ButtonProps & {
  margin?: number | string;
  width?: number | string;
  height?: number | string;
};

const StyledButton = styled(Button)<StyledButtonProps>((props) => ({
  backgroundColor:
    props.variant == "outlined"
      ? props.theme.palette.primary.main
      : props.theme.palette.secondary.main,

  color:
    props.variant == "outlined"
      ? props.theme.palette.secondary.main
      : props.theme.palette.primary.main,

  borderColor:
    props.variant == "outlined" ? props.theme.palette.secondary.main : null,

  fontStyle: "normal",
  fontWeight: 700,
  fontSize: "16px",
  lineHeight: "20px",

  borderRadius: "100px",
  textTransform: "none",

  width: props.width,
  height: props.height,
  padding: "10px 8px",
  margin: props.margin,

  ":hover": {
    backgroundColor: props.theme.palette.secondary.dark,
  },
}));

StyledButton.defaultProps = {
  width: "100%",
  height: "40px",
};

export { StyledButton };
