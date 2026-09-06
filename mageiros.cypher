ALTER CURRENT GRAPH TYPE SET {
  (:category => :object {label :: STRING NOT NULL}),
  (:hom_object => :object&arrow {gloss :: STRING, dual :: STRING}),
  (:morphism => :individual&arrow {gloss :: STRING, dual :: STRING}),
  CONSTRAINT node_ids FOR (n:object) REQUIRE (n.suid) IS KEY,
  (:functor => :object&arrow),
  (:natural_transformation => :object&arrow),
  (:arrow)-[:domain => ]->(:object),
  (:arrow)-[:codomain => ]->(:object),
  (:object)-[:contains => ]->()
                     }
