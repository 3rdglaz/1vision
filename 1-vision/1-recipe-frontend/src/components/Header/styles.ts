import { Toolbar, Typography } from "@mui/material";
import { styled } from "@mui/system";

export const HeaderTitle = styled(Typography)(
  () => `
  font-style: normal;
  font-weight: 700;
  font-size: 32px;
  line-height: 44px;  
  margin: 0;
  `
);

export const LangContainer = styled("div")(
  ({ theme }) => `

    display: flex;
    align-items: center;
    margin: 0 20px;

    & p {
      font-style: normal;
      font-weight: 700;
      font-size: 18px;
      line-height: 20px;
      margin-right: 13px;
      margin-left: 10px;
    }
  
  `
);

export const StyledToolBar = styled(Toolbar)(
  () => `
  display: flex;
  justify-content: space-between;
  align-items: center;

  padding: 18px 0;
  min-height: auto;

  background-color: #FFFF;
  box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
  margin-bottom: 1px;
`
);
