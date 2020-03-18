import 'package:flutter/material.dart';
import 'package:mranderson_voting/animation/backgroundWave.dart';
import 'package:mranderson_voting/model/vote.dart';
import 'package:mranderson_voting/model/voting.dart';

class EnterPassword extends StatelessWidget {
  final passController = TextEditingController();
  final controller = TextEditingController();
  final controllerz = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  EnterPassword(this.voting);

  final Voting voting;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Voting is real"),
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(children: <Widget>[
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(Icons.vpn_key),
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                          child: Row(
                            children: <Widget>[
                              Text(
                                voting.description,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "Still made by: ",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              voting.creator,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
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
                            prefixIcon: Icon(Icons.vpn_key),
                            // myIcon is a 48px-wide widget.
                            hintText: 'Enter the password here'),
                        controller: passController,
                        validator: (value) {
                          if (value.isEmpty || value != voting.passCode) {
                            return 'Please enter the correct password';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 40),
                      TextFormField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Enter your name here'),
                        controller: controller,
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
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Enter the lucky one here'),
                        controller: controllerz,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please enter a valid name';
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
                        child: Text('Vote!'),
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
        sendVote(voting.id, controller.text, controllerz.text).then((_voting) {
          showDialog(barrierDismissible: false,
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: new Text("Noice!"),
                  content: new Text(
                      "You have done your duty, enjoy the results"),
                  actions: <Widget>[
                    // usually buttons at the bottom of the dialog
                    new FlatButton(
                      child: new Text("Close"),
                      onPressed: () {
                        Navigator.popUntil(context, ModalRoute.withName("/"));
                      },
                    ),
                  ],
                );
              });
        });
    }
  }
}
