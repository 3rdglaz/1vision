import { ThemeProvider } from "@mui/material/styles";
import { AppProps } from "next/app";
import { NextIntlProvider } from "next-intl";

import CssBaseline from "@mui/material/CssBaseline";
import theme from "../styles/theme";

import "../styles/globals.css";

type PageProps = {
  messages: IntlMessages;
};

type Props = Omit<AppProps<PageProps>, "pageProps"> & {
  pageProps: PageProps;
};

export default function App({ Component, pageProps }: Props) {
  return (
    <NextIntlProvider messages={pageProps.messages}>
      <ThemeProvider theme={theme}>
        <CssBaseline />
        <Component {...pageProps} />
      </ThemeProvider>
    </NextIntlProvider>
  );
}
