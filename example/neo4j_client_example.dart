import 'package:neo4j_client/neo4j_client.dart';

main() async {
  var client = Neo4jClient('http://localhost:7777');

  Neo4jResponse response =
      await client.send(Neo4jStatement('MATCH (t:Test) RETURN t'));

  response.rows.forEach((row) => {
    //...
  });
}
