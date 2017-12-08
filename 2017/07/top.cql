MATCH (b) WHERE NOT (b)-[:HOLDING]->() RETURN b.name;
