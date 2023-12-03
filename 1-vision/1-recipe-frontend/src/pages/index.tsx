import { Layout } from "@/components/Layout";
import { Timeline } from "@/components/Timeline";

export default function Home() {
  return (
    <Layout>
      <Timeline />
    </Layout>
  );
}

export async function getStaticProps(context: any) {
  return {
    props: {
      messages: (await import(`../../messages/en.json`)).default,
    },
  };
}
