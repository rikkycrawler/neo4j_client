class Neo4jClientRequest {
  final String statement;

  Neo4jClientRequest(this.statement);

  Map<String, dynamic> get json => {
        'statements': [
          {'statement': statement}
        ]
      };
}
