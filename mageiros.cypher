(:category => :object {label :: STRING NOT NULL})
CONSTRAINT node_ids FOR (object) REQUIRE (n.suid) IS KEY
(:functor => :morphism {gloss :: STRING, dual :: STRING})
(:natural_transformation => :2-morphism {gloss :: STRING, dual :: STRING})
(:morphism)-[:domain]->(:object),
(:morphism)-[:codomain]->(:object),
(:category)-[:has_element]->(:object)