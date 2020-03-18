import 'package:flutter/material.dart';
import 'package:mranderson_voting/model/vote.dart';
import 'package:mranderson_voting/model/voting.dart';
import 'package:mranderson_voting/ux/enter_password_voting.dart';

class VoteInfo extends StatelessWidget {

  VoteInfo({
    this.vote
  });

  final Vote vote;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Row(
          children: <Widget>[
            Text("Voter: "),
            Text(vote.voter),
          ],
        ),
        subtitle: Row(
          children: <Widget>[
            Text("Votes for: "),
            Text(vote.votes),
          ],
        )
      ),
    );
  }
}