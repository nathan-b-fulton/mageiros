ALTER CURRENT GRAPH TYPE SET {
  (:category => :object {label :: STRING NOT NULL}),
  (:morphism => :individual&arrow {gloss :: STRING NOT NULL, dual :: STRING}}),
  (:hom_object => :object&arrow {gloss :: STRING NOT NULL, dual :: STRING}),
  (:functor => :object&arrow {gloss :: STRING NOT NULL, dual :: STRING}),
  (:natural_transformation => :object&arrow {gloss :: STRING NOT NULL, dual :: STRING}),
  CONSTRAINT node_ids FOR (n:object) REQUIRE (n.suid) IS KEY,
  (:arrow)-[:domain => ]->(:object),
  (:arrow)-[:codomain => ]->(:object),
  (:object)-[:contains => ]->()
                     }
