import { Box, Dialog, DialogContent, List } from "@mui/material";
import { useTranslations } from "next-intl";
import {
  ContainerSideMenu,
  StyledListItem,
  StyledSubTitle,
  StyledTitle,
} from "./styles";

import { StyledDivider } from "@/shared/Divider";
import { StyledButton } from "@/shared/Button";
import { Edit, NavigateNext } from "@mui/icons-material";

import { useRouter } from "next/router";
import { useState } from "react";
import { SignIn } from "../SignIn";

import Image from "next/image";
import Link from "next/link";

type Props = {};

export const SideMenu = (props: Props) => {
  const t = useTranslations("SideMenu");
  const router = useRouter();

  const [openModal, setOpenModal] = useState(false);

  const handleOpenModal = () => {
    setOpenModal(!openModal);
  };

  return (
    <>
      <ContainerSideMenu>
        <StyledTitle>{t("title")}</StyledTitle>

        <List component="nav" style={{ marginBottom: 30 }}>
          <StyledListItem>
            <Image
              src="/images/home.svg"
              alt={t("title")}
              width={24}
              height={24}
            />
            <Link href="/">{t("home")}</Link>
            <NavigateNext />
          </StyledListItem>
          <StyledListItem>
            <Image
              src="/images/leaf.svg"
              alt={t("ingredients")}
              width={24}
              height={24}
            />
            <Link href="/ingredients">{t("ingredients")}</Link>
            <NavigateNext />
          </StyledListItem>
          <StyledListItem>
            <Image
              src="/images/union.svg"
              alt={t("cusine")}
              width={24}
              height={24}
            />
            <Link href="/cusine">{t("cusine")}</Link>
            <NavigateNext />
          </StyledListItem>
          <StyledListItem>
            <Image
              src="/images/watch.svg"
              alt={t("time")}
              width={24}
              height={24}
            />
            <Link href="/time">{t("time")}</Link>
            <NavigateNext />
          </StyledListItem>
        </List>

        <StyledButton
          endIcon={<Edit />}
          onClick={() => {
            router.push("/post-recipe");
          }}
        >
          {t("buttonPost")}
        </StyledButton>

        <StyledDivider margin="34px 0" />

        <StyledTitle>{t("newAroundHere")}</StyledTitle>

        <StyledButton variant="outlined" margin="34px 0 0 0">
          {t("signUpGoogle")}
        </StyledButton>

        <StyledButton variant="outlined" margin="20px 0 32px 0">
          {t("signUpApple")}
        </StyledButton>

        <StyledSubTitle>{t("orYouCanAlso")}</StyledSubTitle>

        <StyledButton
          onClick={handleOpenModal}
          variant="outlined"
          margin="18px 0 0 0"
        >
          {t("createAnAccount")}
        </StyledButton>

        <StyledDivider margin="34px 0" />

        <StyledTitle>{t("alreadyHaveAccount")}</StyledTitle>

        <StyledButton onClick={handleOpenModal} margin="24px 0 0 0">
          {t("signIn")}
        </StyledButton>
      </ContainerSideMenu>
      <Dialog open={openModal} onClose={handleOpenModal} keepMounted>
        <Box padding="40px 100px">
          <SignIn />
        </Box>
      </Dialog>
    </>
  );
};
