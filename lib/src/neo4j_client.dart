import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/io_client.dart';

import './neo4j_response.dart';
import './neo4j_request.dart';

class Neo4jClient {
  final Uri _apiUri;
  final BaseClient _httpClient;

  Neo4jClient(String uri, {BaseClient httpClient})
      : _apiUri = Uri.parse('${uri}/db/data/transaction/commit'),
        _httpClient = httpClient ?? IOClient();

  Future<Neo4jResponse> send(Neo4jRequest request) async {
    Response response = await _httpClient.post(_apiUri,
        body: request.statementsStr,
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json'
        });

    if (response.statusCode != 200) return throw Exception(response.body);

    return Neo4jResponse.parse(json.decode(response.body));
  }

  String toCypherObject(Map obj, {cypherEncodable(object)}) {
    final encoded = obj.entries.fold<List<String>>([], (encodedEntries, entry) {
      if (entry.value is Map && cypherEncodable == null) return encodedEntries;

      return encodedEntries
        ..add(
            '${entry.key}: ${cypherEncodable == null ? json.encode(entry.value, toEncodable: toEncodable) : cypherEncodable(entry)}');
    }).join(', ');

    return '{$encoded}';
  }
}

dynamic toEncodable(value) {
  if (value is DateTime) return value.toUtc().toIso8601String();
  return '';
}
