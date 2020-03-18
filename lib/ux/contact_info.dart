import 'package:flutter/material.dart';
import 'package:mranderson_voting/model/voting.dart';
import 'package:mranderson_voting/ux/enter_password_voting.dart';

class VotingInfo extends StatelessWidget {
  VotingInfo({this.voting});

  final Voting voting;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () {
            _openVotingRoom(context);
          },
          title: Text(voting.description),
          subtitle: Row(
            children: <Widget>[
              Text("Made by: "),
              Text(voting.creator),
            ],
          )),
    );
  }

  void _openVotingRoom(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EnterPassword(voting)),
    );
  }
}
