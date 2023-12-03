import { Head, Html, Main, NextScript } from "next/document";
import theme, { nunito } from "../styles/theme";

export default function Document(props: any) {
  return (
    <Html lang={props.locale} className={nunito.className}>
      <Head>
        {/* PWA primary color */}
        <meta name="theme-color" content={theme.palette.primary.main} />
        <link rel="shortcut icon" href="/favicon.ico" />
      </Head>
      <body>
        <Main />
        <NextScript />
      </body>
    </Html>
  );
}
