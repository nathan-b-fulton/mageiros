# Core structures and translating between levels

## Semantic Primitives
- The conceptual primitives used in the Semantic mode are "schemata", "entities", and "relations".
- Generally speaking, entities are shown as nodes in a graph. Relations are shown as edges.
- The graphs shown in Semantic mode are _not_ the graphs stored in Neo4j.
  - Semantic mode content is formalized into category theory.
  - The category theory formalization is stored using the 2-category framework found in `mageiros.cypher`.
  - Composition is strict across the transitions between modes, so every structure created in the Semantic mode has a single correct translation to the persistent layer in Neo4j, and Neo4j data always has a defined interpretation in the Semantic layer presentation.
- Schemata correspond to categories, and come in sub-types depending on their contents and properties.

## Very Simple Schemata
- An "empty schema" has no entities in it.
  - It is translated into something technically equivalent up to unique isomorphism to the empty category, but such a category may still be persisted as a unique `:category` node as long as its `label` property has been supplied.
  - This is usually just a temporary state found before the user adds some entities to the schema.
- A schema that only has entities is a "controlled vocabulary", and is translated into a discrete category in Categorical mode.

## Taxonomies
A schema that has entities connected by the default relationship type, "subtype of", is a "taxonomy".
- It is translated into a skeletal (posetal) category by default, referred to in Semantic mode as a "strict taxonomy".
- The user may weaken this to a thin (preorder) category, or "relaxed taxonomy".
- They may then weaken that further to a directed acyclic graph category, or "weak taxonomy".
- Further weakening is not permitted.
  - At a future time, we will support digraphs that are permitted to have cycles, but they will no be considered taxonomies.
  - There is no plan to support undirected graphs; any use case for this should probably be satisfied by labeling isomorphisms (see below).
- As a preorder (or preorder-like DAG), a taxonomy is enriched in `Bool`. The "subtype of" relations in a taxonomy should be shown as hom-objects from `Bool` at the Category level, and stored as such at the Graph level.
- It is very common for a larger taxonomy called a "compound taxonomy" to be created from two or more base taxonomies.
  - The compound taxonomy is a product category induced by the categories corresponding to the base taxonomies.
  - Taxonomies used as base categories in this way are also called "facets".
 
## Ontologies
A schema that has more customized relations, usually multiple types, is an "ontology".
- Ontologies can be quite complex structures, usually composed using taxonomies as base categories.
- They may include more advanced elements, especially fibrations and sheaves.
- Because they are more complex and less standardized, specific patterns will be developed and documented separately.
