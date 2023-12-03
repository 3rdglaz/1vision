import { Box } from "@mui/system";
import { Header } from "../Header";
import { SideMenu } from "../SideMenu";

type Props = {
  sideMenu?: boolean;
  children: React.ReactNode;
};

export const Layout = ({ sideMenu = true, children }: Props) => {
  return (
    <>
      <Header />
      <Box display="flex" justifyContent="space-between">
        {sideMenu && <SideMenu />}
        {children}
      </Box>
    </>
  );
};
