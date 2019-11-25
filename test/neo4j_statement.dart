import 'package:neo4j_client/neo4j_client.dart';
import 'package:test/test.dart';

void main() {
  test('Neo4j Statement', () {
    var request = Neo4jStatement('MATCH (t:Test) RETURN t');
    expect(request.json,  {'statement': 'MATCH (t:Test) RETURN t'});
  });
}