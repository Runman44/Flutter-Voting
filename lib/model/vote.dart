import 'dart:convert' show json;
import 'package:http/http.dart' as http;

class Vote {
  final int id;
  final int votingId;
  final String voter;
  final String votes;

  Vote(this.id, this.votingId, this.voter, this.votes);

  factory Vote.fromJson(Map<String, dynamic> json) {
    int id = json['id'];
    int votingId = json['votingId'];
    String voter = json['voter'];
    String votes = json['votes'];
    return Vote(id, votingId, voter, votes);
  }
}

Future<List<Vote>> getAllVotes(int votingId) async {
  final response = await http.get("https://voting-app-mr-anderson.herokuapp.com/v1/vote/$votingId");

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    Iterable list = json.decode(response.body);
    return list.map((model) => Vote.fromJson(model)).toList();
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future<Vote> sendVote(int votingId, String voter, String votes) async {

  String jsonz = '{"voter": "$voter", "votes": "$votes"}';
//  String headerz = '{"Accept": "application/json", "Content-Type": "application/json"}';
  Map<String, String> headerzz = {"Accept": "application/json", "Content-type": "application/json"};

  final response = await http.post("https://voting-app-mr-anderson.herokuapp.com/v1/vote/$votingId", headers: headerzz , body: jsonz);

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return Vote.fromJson(json.decode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}
