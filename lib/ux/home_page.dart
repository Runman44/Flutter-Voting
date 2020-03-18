
import 'package:flutter/material.dart';
import 'package:mranderson_voting/model/voting.dart';
import 'package:mranderson_voting/ux/contact_info.dart';
import 'package:mranderson_voting/ux/create_voting.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SwipeToRefreshState();
  }
}

class _SwipeToRefreshState extends State<HomePage> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  List<Voting> voting = new List<Voting>();

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text("Let's Vote"),
      ),
      body: RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView.builder(
            itemCount: voting.length,
            itemBuilder: (context, index) {
              return VotingInfo(
                voting: voting[index]
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateVoting()),
          );
        },
        tooltip: 'Add new voting',
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _refresh() {
    return getVotings().then((_voting) {
      setState(() => voting = _voting);
    });
  }
}