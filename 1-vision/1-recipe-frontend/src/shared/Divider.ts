import { Container, ContainerProps } from "@mui/material";
import { styled } from "@mui/system";

type StyledDividerProps = ContainerProps & {
  margin?: number | string;
};

const StyledDivider = styled(Container)<StyledDividerProps>(({ margin }) => ({
  backgroundColor: "#D9D9D9",
  height: "2px",
  width: "100%",
  margin: margin,
}));

StyledDivider.defaultProps = {
  margin: "20px 0",
};

export { StyledDivider };
