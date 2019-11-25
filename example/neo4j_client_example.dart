import 'package:neo4j_client/neo4j_client.dart';

main() async {
  var client = Neo4jClient('http://localhost:7474');

  client.addStatement(Neo4jStatement('MATCH (u:User) RETURN ut'));
  Neo4jResponse response =
      await client.send(Neo4jStatement('MATCH (o:Organization) RETURN o'));

  response.results.forEach((result) => {
        //..
      });
}
