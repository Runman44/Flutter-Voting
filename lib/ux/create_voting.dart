import 'package:flutter/material.dart';
import 'package:mranderson_voting/animation/backgroundWave.dart';
import 'package:mranderson_voting/model/voting.dart';

import 'collect_votes.dart';

class CreateVoting extends StatelessWidget {
  final creatorController = TextEditingController();
  final controllerz = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lets create a voting!"),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child:
              Column(children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.warning),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  "Make sure to stand out with the voting name!",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 40),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Enter your name here'),
                        controller: creatorController,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        decoration:
                        InputDecoration(
                            prefixIcon: Icon(Icons.description),
                            hintText: 'Enter a nice name for the voting'),
                        controller: controllerz,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid voting name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40),
                      RaisedButton(
                        padding: const EdgeInsets.all(12.0),
                        color: Theme
                            .of(context)
                            .primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          _onVoteTapped(context);
                        },
                        child: Text('Create!'),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(18.0),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            ),
          ),
          Positioned(
            child: new Align(
                alignment: FractionalOffset.bottomCenter,
                child: Container(height: 100, child: FancyBackgroundApp())),
          ),
        ],
      ),
    );
  }

  void _onVoteTapped(BuildContext context) {
    if (_formKey.currentState.validate()) {
      createVoting(creatorController.text, controllerz.text).then((_voting) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CollectVotes(_voting)),
        );
      });
    }
  }
}
