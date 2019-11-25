import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:neo4j_client/neo4j_client.dart';
import 'package:test/test.dart';

import './data/test_json.dart';

void main() {
  test('request-response', () async {
    String body;
    Map<String, String> headers;
    String url;

    var mockClient = MockClient((request) async {
      body = request.body;
      headers = request.headers;
      url = request.url.toString();

      return Response(json.encode(testJson), 200);
    });

    var client = Neo4jClient('http://localhost:7777', httpClient: mockClient);
    Neo4jResponse response =
        await client.send(Neo4jStatement('MATCH (t:Test) RETURN t'));

    expect(url, 'http://localhost:7777/db/data/transaction/commit');
    expect(body, '{"statements":[{"statement":"MATCH (t:Test) RETURN t"}]}');
    expect(headers, {
      'Accept': 'application/json; charset=UTF-8',
      'Content-Type': 'application/json; charset=utf-8'
    });

    expect(response.results[0].columns, ["columns"]);
    expect(response.results[0].rows, [
      [
        {'property_1': 'test_1', 'property_2': 'test_2', 'property_3': 'test_3'}
      ],
      [
        {'property_4': 'test_5', 'property_6': 'test_7', 'property_8': 'test_8'}
      ]
    ]);
    expect(response.errors, []);
  });

  test('toCypherObject', () async {
    var client = Neo4jClient('http://localhost:7777');
    expect(client.toCypherObject({'a': 'b', 'c': 'd', 'e': 'f'}),
        '{a: "b", c: "d", e: "f"}');
  });
}
