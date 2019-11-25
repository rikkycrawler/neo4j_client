class Neo4jStatement {
  final String statement;

  Neo4jStatement(this.statement);

  Map<String, dynamic> get json => {'statement': statement};
}
