import 'dart:convert' show json;
import 'package:http/http.dart' as http;

class Voting {
  final int id;
  final String description;
  final String creator;
  final String passCode;

  Voting(this.id, this.description, this.creator, this.passCode);

  factory Voting.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    String description = json['description'];
    String creator = json['creator'];
    String passCode = json['passCode'];
    return Voting(id, description, creator, passCode);
  }
}

Future<List<Voting>> getVotings() async {
  final response = await http.get("http://192.168.2.204:8080/v1/voting");

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Iterable list = json.decode(response.body);
    return list.map((model) => Voting.fromJson(model)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<http.Response> deleteVoting(int votingId) async {
  return await http.delete("http://192.168.2.204:8080/v1/voting/$votingId");
}

Future<Voting> createVoting(String creator, String description) async {

  String jsonz = '{"description": "$description", "creator": "$creator"}';
//  String headerz = '{"Accept": "application/json", "Content-Type": "application/json"}';
  Map<String, String> headerzz = {"Accept": "application/json", "Content-type": "application/json"};

  final response = await http.post("http://192.168.2.204:8080/v1/voting", headers: headerzz, body: jsonz);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Voting.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to create a voting');
  }
}





