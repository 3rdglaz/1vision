/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  i18n: {
    locales: ["en", "pt"],
    defaultLocale: "en",
  },
  images: {
    domains: ["picsum.photos"],
  },
};

module.exports = nextConfig;
