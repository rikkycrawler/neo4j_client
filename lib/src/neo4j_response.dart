/// Neo4j Client Response
class Neo4jResponse {
  /// Columns response
  final List results;

  /// Error response
  final List errors;

  Neo4jResponse({this.results, this.errors});

  factory Neo4jResponse.parse(Map<String, dynamic> json) {
    if (json == null) return null;

    return Neo4jResponse(
        results:
            json['results'].map((result) => Neo4jResult.parse(result)).toList(),
        errors:
            json['errors'].map((error) => Neo4jError.parse(error)).toList());
  }
}

/// Neo4j Client Result
class Neo4jResult {
  /// Columns neo4j result
  final List<String> columns;

  /// Rows neo4j result
  final List rows;

  Neo4jResult({this.columns, this.rows});

  factory Neo4jResult.parse(Map<String, dynamic> json) {
    if (json == null) return null;

    return Neo4jResult(
        columns: List<String>.from(['columns']),
        rows: json['data'].map((data) => data['row']).toList());
  }
}

/// Neo4j Client Error
class Neo4jError {
  /// Neo4j error code
  final String code;

  /// Error message
  final String message;

  Neo4jError({this.code, this.message});

  factory Neo4jError.parse(Map<String, dynamic> json) {
    if (json == null) return null;

    return Neo4jError(code: json['code'], message: json['message']);
  }
}
