import { Chip, Grid, Typography } from "@mui/material";
import { styled } from "@mui/system";
import Image from "next/image";

export const StyledGrid = styled(Grid)((props) => ({
  background: props.theme.palette.primary.main,
  border: "1px solid #C0C0C0",
  boxShadow: "0px 4px 4px rgba(0, 0, 0, 0.25)",
  borderRadius: "16px",
  marginBottom: props.theme.spacing(3),
}));

export const StyledTitle = styled(Typography)(({ fontWeight }) => ({
  fontStyle: "normal",
  fontWeight: `${fontWeight}`,
  fontSize: "24px",
  lineHeight: "32px",
  margin: 0,
  color: "#000",
}));

export const StyledImage = styled(Image)((props) => ({
  objectFit: "cover",
  width: "100%",
  marginBottom: "10px",
}));

export const StyledChip = styled(Chip)((props) => ({
  border: "1px solid #79747E",
  borderRadius: "8px",
  marginRight: 18,
  height: 32,

  fontFamily: "Roboto",
  fontStyle: "normal",
  fontWeight: 500,
  fontSize: "14px",
  lineHeight: "20px",
}));

export const StyledLikes = styled(Typography)(({ theme }) => ({
  fontStyle: "normal",
  fontWeight: 700,
  fontSize: "16px",
  lineHeight: "20px",
  letterSpacing: "0.1px",
  color: theme.palette.secondary.main,
}));
