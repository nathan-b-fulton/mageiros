# mageiros
A framework and reference implementation for semantic data architecture based on modern mathematics: categories, types, and topoi.

## Tech Stack

- This project is primarily written in Python. The intent is for the code itself to be fairly accessible to a broad audience with a mixed range of technical background.
- In this reference implementation, the ontological layers are persisted using Neo4j, and the data layers are persisted using MongoDB.
- The GUI is written in PyQt6.
- None of that is essential. We encourage porting the framework to other architectures, adopting the core design patterns illustrated to other contexts, and generally treating the project as a laboratory rather than a factory, a means of research rather than production.

## The General Idea

This project aims to integrate three perspectives:
- Semantic Data Management (taxonomy, ontology, knowledge management, GOFAI...)
- Semantic Machine Learning (embeddings, semantic IDs, graph neural networks...)
- Modern abstract mathematics and computer science (category, type, and topos theory)

This is not, however, simply an exercise in creating theoretical connections between methodologies in different fields. It is a practical platform for synthesizing disparate techniques into powerful but accessible tools for classification, inference, and knowledge formation.

## UI Modes

Mageiros offers three modes for viewing and interacting with structures and data:

- Semantic mode: The default and most feature-rich mode. Semantic mode focuses on intuitive presentation of collections and relationships, easy access to textual information, and built-in tooling for ontology development and inference.
- Categorical mode: This mode offers more rigorous presentation of the mathematical foundations of the system, for research, study, or formal validation.
- Graph mode: Direct visualization of the persistent graph layer, which is a 2-category framework with extensions to represent categories, functors, and natural transformations.
