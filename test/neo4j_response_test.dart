import 'package:neo4j_client/neo4j_client.dart';
import 'package:test/test.dart';

import './data/test_json.dart';

void main() {

  test('Neo4j Response', () {
    var response = Neo4jResponse.parse(testJson);

    expect(response.results.first, TypeMatcher<Neo4jResult>());
    expect(response.results.first.columns, ['columns']);
    expect(response.results.first.rows, [
      [{'property_1': 'test_1', 'property_2': 'test_2', 'property_3': 'test_3'}],
      [{'property_4': 'test_5', 'property_6': 'test_7', 'property_8': 'test_8'}]
    ]);
    expect(response.errors, []);
  });

  test('Neo4j Result', (){
    var result = Neo4jResult.parse({'columns': ['test'], 'data': [{'row': [{'property_1': 'test_1', 'property_2': 'test_2', 'property_3': 'test_3'}]}]});

    expect(result.columns, ['columns']);
    expect(result.rows, [[{'property_1': 'test_1', 'property_2': 'test_2', 'property_3': 'test_3'}]]);
  });

  test('Neo4j Error', (){
    var error = Neo4jError.parse({'code': 'Neo.ClientError.Statement.SyntaxError', 'message': 'Variable `ut` not defined (line 1, column 23 (offset: 22)) "MATCH (u:User) RETURN ut"'});

    expect(error.code, 'Neo.ClientError.Statement.SyntaxError');
    expect(error.message, 'Variable `ut` not defined (line 1, column 23 (offset: 22)) "MATCH (u:User) RETURN ut"');
  });

}