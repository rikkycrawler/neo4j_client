import 'dart:convert';

class Neo4jRequest {
  List<String> _statements = [];
  Neo4jRequest();

  void addStatement(String statement) => _statements.add(statement);

  String get statementsStr => json.encode({
    'statements': _statements.map((statement) => {'statement': statement}).toList()
  });

  void clearStatements() => _statements = [];
}
