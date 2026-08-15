(:category => :object {label :: STRING NOT NULL})
CONSTRAINT node_ids FOR (object) REQUIRE (n.suid) IS KEY
(:functor => :morphism {gloss :: STRING, dual :: STRING})
(:natural_transformation => :k_morphism {gloss :: STRING, dual :: STRING, k :: INTEGER})
(:morphism)-[:domain]->(:object),
(:morphism)-[:codomain]->(:object),
(:category)-[:has_element]->(:object)
