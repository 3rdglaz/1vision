import { Layout } from "@/components/Layout";

export default function PostRecipe() {
  return (
    <Layout>
      <div>post-recipe</div>
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
