HttpClient for Neo4j on Dart 

## Usage

A simple usage example:

```dart
import 'package:neo4j_client/neo4j_client.dart';

main() async {
  var client = Neo4jClient('http://localhost:7474');

  client.addStatement(Neo4jStatement('MATCH (t:Test) RETURN t'));
  Neo4jResponse response =
      await client.send(Neo4jStatement('MATCH (n:Node) RETURN n'));

  response.results.forEach((result) => {
    //..
  });
}
```

