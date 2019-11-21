import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart';
import 'package:http/io_client.dart';

import './neo4j_client_request.dart';
import './neo4j_client_response.dart';

class Neo4jClient {
  final Uri _apiUri;
  final BaseClient _httpClient;

  Neo4jClient(String uri, {BaseClient httpClient})
      : _apiUri = Uri.parse('${uri}/db/data/transaction/commit'),
        _httpClient = httpClient ?? IOClient();

  Future<Neo4jClientResponse> request(Neo4jClientRequest request) async {
    Response response = await _httpClient.post(_apiUri,
        body: json.encode(request.json),
        headers: {
          'Accept': 'application/json; charset=UTF-8',
          'Content-Type': 'application/json'
        });

    if (response.statusCode != 200) return throw Exception(response.body);

    return Neo4jClientResponse.fromJson(json.decode(response.body));
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
