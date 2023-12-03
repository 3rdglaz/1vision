import { Card, Grid, Typography } from "@mui/material";
import { StyledText, StyledTextField, StyledTitle } from "./styles";
import { StyledButton } from "@/shared/Button";
import { useTranslations } from "next-intl";
import Image from "next/image";
import { StyledDivider } from "@/shared/Divider";

type Props = {};

export const SignIn = (props: Props) => {
  const t = useTranslations("Header");

  return (
    <Grid container alignContent="flex-start" rowGap={4}>
      <Grid item xs={12} container justifyContent="center" alignItems="center">
        <Image
          src="/images/1-logo.png"
          alt={t("appName")}
          width={20}
          height={32}
          style={{ marginRight: 2 }}
        />
        <StyledTitle>{t("appShortName")}</StyledTitle>
      </Grid>
      <Grid item xs={12}>
        <Typography variant="h6" align="center" marginBottom="24px">
          Sign In
        </Typography>
        <StyledTextField fullWidth placeholder="Email" />
        <StyledTextField fullWidth placeholder="Password" />
      </Grid>
      <Grid item xs={12} container justifyContent="space-around">
        <StyledButton width={190} variant="outlined">
          Cancel
        </StyledButton>
        <StyledButton width={190}>Create Account</StyledButton>
      </Grid>

      <StyledDivider margin="0" />

      <Grid item xs={12} container>
        <StyledText>Forgot your password?</StyledText>
        <StyledText>
          <strong>Reset password</strong>
        </StyledText>
      </Grid>
    </Grid>
  );
};
