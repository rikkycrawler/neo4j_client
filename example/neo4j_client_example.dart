import 'package:neo4j_client/neo4j_client.dart';

main() async {
  var client = Neo4jClient('http://localhost:7474');
  var request = Neo4jRequest()..addStatement('MATCH (u:User) RETURN ut')..addStatement('MATCH (t:Test) RETURN t');

  Neo4jResponse response = await client.send(request);

  response.results.forEach((result) => {
    // ...
  });
}
