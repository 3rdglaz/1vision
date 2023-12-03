import { ListItem, Typography } from "@mui/material";
import { styled } from "@mui/system";

export const ContainerSideMenu = styled("div")(({ theme }) => ({
  backgroundColor: theme.palette.primary.main,
  minWidth: 400,
  padding: "24px 24px 50px 38px",
  boxShadow: "0px 4px 10px rgba(0, 0, 0, 0.1)",
  marginRight: "1px",
}));

export const StyledTitle = styled(Typography)(() => ({
  fontStyle: "normal",
  fontWeight: 700,
  fontSize: "24px",
  lineHeight: "32px",
  margin: 0,
}));

export const StyledSubTitle = styled(Typography)(() => ({
  fontStyle: "normal",
  fontWeight: 400,
  fontSize: "16px",
  lineHeight: "20px",
  margin: 0,
}));

export const StyledListItem = styled(ListItem)(() => ({
  paddingLeft: 0,
  marginTop: 24,

  "& a": {
    fontStyle: "normal",
    fontWeight: 700,
    fontSize: "18px",
    lineHeight: "20px",
    color: "#000",
    textDecoration: "none",

    marginLeft: "20px",
    marginRight: "14px",
  },

  "& svg": {
    width: "0.75em",
    height: "0.75em",
  },
}));
