import { defineCollection, z } from 'astro:content';
import { glob } from 'astro/loaders';

const blogCollection = defineCollection({
	loader: glob({ pattern: '**\/[^_]*.md', base: "./src/content/blog" }),
	schema: z.object({
		title: z.string(),
		subheading: z.string(),
		description: z.string(),
		pubDate: z.coerce.date(),
		updatedDate: z.coerce.date().optional(),
		heroImage: z.string().optional(),
		tags: z.array(z.string()).optional(),
	}),
});

export const collections = {
  'blog': blogCollection,
};
