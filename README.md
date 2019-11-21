HttpClient for Neo4j on Dart 

## Usage

A simple usage example:

```dart
import 'package:neo4j_client/neo4j_client.dart';

main() async {
  var client = Neo4jClient('http://localhost:7777');
  
  Neo4jClientResponse response = await client.request(Neo4jClientRequest('MATCH (t:Test) RETURN t'));
  
  response.rows.forEach((row) => {
    //...
  });
}
```

