import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:neo4j_client/neo4j_client.dart';
import 'package:neo4j_client/src/neo4j_client_request.dart';
import 'package:test/test.dart';

import './data/test_json.dart';

void main() {
  test('Neo4jClient Request', () {
    var request = Neo4jClientRequest('MATCH (t:Test) RETURN t');
    expect(request.json, {
      'statements': [
        {'statement': 'MATCH (t:Test) RETURN t'}
      ]
    });
  });

  test('Neo4jClient Response', () {
    var response = Neo4jClientResponse.fromJson(testJson);

    expect(response.columns, ["test"]);
    expect(response.errors, []);
    expect(response.rows, [
      {"property_1": "test_1", "property_2": "test_2", "property_3": "test_3"},
      {"property_4": "test_5", "property_6": "test_7", "property_8": "test_8"}
    ]);
  });

  group('Neo4jClient', () {
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
      Neo4jClientResponse response =
          await client.request(Neo4jClientRequest('MATCH (t:Test) RETURN t'));

      expect(url, 'http://localhost:7777/db/data/transaction/commit');
      expect(body, '{"statements":[{"statement":"MATCH (t:Test) RETURN t"}]}');
      expect(headers, {
        'Accept': 'application/json; charset=UTF-8',
        'Content-Type': 'application/json; charset=utf-8'
      });
      expect(response.columns, ["test"]);
      expect(response.errors, []);
      expect(response.rows, [
        {
          "property_1": "test_1",
          "property_2": "test_2",
          "property_3": "test_3"
        },
        {"property_4": "test_5", "property_6": "test_7", "property_8": "test_8"}
      ]);
    });

    test('toCypherObject', () async {
      var client = Neo4jClient('http://localhost:7777');
      expect(client.toCypherObject({'a': 'b', 'c': 'd', 'e': 'f'}),
          '{a: "b", c: "d", e: "f"}');
    });
  });
}
