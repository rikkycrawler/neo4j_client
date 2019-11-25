import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/io_client.dart';
import 'package:neo4j_client/src/neo4j_statement.dart';

import './neo4j_response.dart';
import './neo4j_statement.dart';

class Neo4jClient {
  final Uri _apiUri;
  final BaseClient _httpClient;

  Neo4jClient(String uri, {BaseClient httpClient})
      : _apiUri = Uri.parse('${uri}/db/data/transaction/commit'),
        _httpClient = httpClient ?? IOClient();

  List<Neo4jStatement> _statements = [];

  void addStatement(Neo4jStatement statement) => _statements.add(statement);

  Future<Neo4jResponse> send(Neo4jStatement statement) async {
    if (statement != null) addStatement(statement);

    Response response = await _httpClient.post(_apiUri,
        body: json.encode({
          'statements': _statements.map((statement) => statement.json).toList()
        }),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json'
        });

    _statements = [];

    if (response.statusCode != 200) return throw Exception(response.body);

    return Neo4jResponse.parse(json.decode(response.body));
  }

  String toCypherObject(Map obj, {cypherEncodable(object)}) {
    final encoded = obj.entries.fold<List<String>>([], (encodedEntries, entry) {
      if (entry.value is Map) return encodedEntries;

      return encodedEntries
        ..add(
            '${entry.key}: ${cypherEncodable == null ? json.encode(entry.value) : cypherEncodable(entry)}');
    }).join(', ');

    return '{$encoded}';
  }
}
