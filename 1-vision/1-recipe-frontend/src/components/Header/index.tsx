import { useState } from "react";
import { AppBar, Menu, MenuItem, Typography } from "@mui/material";
import { StyledToolBar, LangContainer, HeaderTitle } from "./styles";
import { useTranslations } from "next-intl";
import Image from "next/image";
import LanguageIcon from "@mui/icons-material/Language";
import ExpandMoreIcon from "@mui/icons-material/ExpandMore";

type Props = {};

export const Header = (props: Props) => {
  const t = useTranslations("Header");
  const [anchorEl, setAnchorEl] = useState<null | HTMLElement>(null);

  const handleClose = () => {
    setAnchorEl(null);
  };

  return (
    <StyledToolBar>
      <div></div>

      <HeaderTitle>
        <Image
          src="/images/1-logo.png"
          alt={t("appName")}
          width={20}
          height={32}
          style={{ marginRight: 2 }}
        />
        {t("appShortName")}
      </HeaderTitle>

      <LangContainer
        onClick={(e) => {
          setAnchorEl(e.currentTarget);
        }}
      >
        <LanguageIcon color="secondary" />
        <ExpandMoreIcon />
        <Typography>{t("language")}</Typography>
      </LangContainer>

      <Menu
        id="basic-menu"
        anchorEl={anchorEl}
        open={Boolean(anchorEl)}
        onClose={handleClose}
        MenuListProps={{
          "aria-labelledby": "basic-button",
        }}
      >
        <MenuItem onClick={handleClose}>English</MenuItem>
        <MenuItem onClick={handleClose}>Spanish</MenuItem>
        <MenuItem onClick={handleClose}>Portuguese</MenuItem>
      </Menu>
    </StyledToolBar>
  );
};
