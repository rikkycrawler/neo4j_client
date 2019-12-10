import 'package:neo4j_client/neo4j_client.dart';
import 'package:test/test.dart';

void main() {
  test('Neo4jRequest addStatement', () {
    var request = Neo4jRequest()..addStatement('MATCH (t:Test) RETURN t')..addStatement('MATCH (t2:Test2) RETURN t2');
    expect(request.statementsStr, '{"statements":[{"statement":"MATCH (t:Test) RETURN t"},{"statement":"MATCH (t2:Test2) RETURN t2"}]}');
  });

  test('Neo4jRequest clearStatements', () {
    var request = Neo4jRequest()..addStatement('MATCH (t:Test) RETURN t')..addStatement('MATCH (t2:Test2) RETURN t2');
    request.clearStatements();
    expect(request.statementsStr, '{"statements":[]}');
  });
}
