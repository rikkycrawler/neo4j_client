/// Neo4j Client Response
class Neo4jResponse {
  /// Columns response
  final List<String> columns;

  /// Error response
  final List errors;

  /// Rows response
  final List<Map<String, dynamic>> rows;

  Neo4jResponse({this.columns, this.errors, this.rows});

  factory Neo4jResponse.fromJson(Map<String, dynamic> json) {
    if (json == null) return null;

    List resultsData = [];
    List columns = json['results'].single['columns'];

    json['results'].single['data'].forEach((data) {
      Map<String, dynamic> rowMap = {};

      data['row'].asMap().forEach((rowId, row) {
        rowMap[columns[rowId]] = row;
      });

      resultsData.add(rowMap);
    });

    return Neo4jResponse(
        columns: List<String>.from(json['results'].single['columns']),
        errors: json['errors'],
        rows: List<Map<String, dynamic>>.from(
            json['results'].single['data'].map((data) => data['row'].single)));
  }
}
