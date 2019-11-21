HttpClient for Neo4j on Dart 

## Usage

A simple usage example:

```dart
import 'package:neo4j_client/neo4j_client.dart';

main() async {
  Neo4jResponse response =
      await client.send(Neo4jStatement('MATCH (t:Test) RETURN t'));

  response.rows.forEach((row) => {
    //...
  });
}
```

