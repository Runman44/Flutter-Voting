import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mranderson_voting/model/vote.dart';
import 'package:mranderson_voting/model/voting.dart';
import 'package:mranderson_voting/ux/vote_info.dart';
import 'package:share/share.dart';

class CollectVotes extends StatefulWidget {
  final Voting voting;

  CollectVotes(this.voting);

  @override
  State<StatefulWidget> createState() {
    return _SwipeToRefreshState(voting);
  }
}

class _SwipeToRefreshState extends State<CollectVotes> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();

  List<Vote> votes = new List<Vote>();

  final Voting voting;

  _SwipeToRefreshState(this.voting);

  @override
  void initState() {
    _refresh();
    new Future.delayed(const Duration(seconds: 1))
        .then((_)=> _buildSnackBar()
    );
    super.initState();
  }

  _buildSnackBar (){
    if(kIsWeb)
    {
      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: Text("Share this code: " + voting.passCode),
            duration: Duration(hours: 99),
          )
      );
    } else {
      _scaffoldKey.currentState.showSnackBar(
          new SnackBar(
            content: Text("Share this code: " + voting.passCode),
            duration: Duration(hours: 99),

            action: SnackBarAction(
              label: 'Share',
              onPressed: () {
                Share.share(voting.passCode);
              },
            ),
          )
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Who wins? You decide!"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: SizedBox(
              height: 200.0,
              child: RefreshIndicator(
                key: _refreshIndicatorKey,
                onRefresh: _refresh,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: ListView.builder(
                    itemCount: votes.length,
                    itemBuilder: (context, index) {
                      return VoteInfo(vote: votes[index]);
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _onDeleteTapped(context);
        },
        tooltip: 'Add new voting',
        child: Icon(Icons.delete),
      ),
    );
  }


  void _onDeleteTapped(BuildContext context) {
    deleteVoting(voting.id).then((_voting) {
      Navigator.popUntil(context, ModalRoute.withName("/"));
    });
  }

  Future<void> _refresh() {
    return getAllVotes(voting.id).then((_votes) {
      setState(() => votes = _votes);
    });
  }
}
