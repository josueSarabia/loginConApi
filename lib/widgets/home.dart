import 'package:flutter/material.dart';
import 'package:calculadoranotifier/model.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(builder: (context, model, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Home'),
          ),
          body: Container(
            child: Column(
              children: <Widget>[
                FutureBuilder(
                    future: model.getUser(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData)
                        return Container(); // still loading
                      // alternatively use snapshot.connectionState != ConnectionState.done
                      final String user = snapshot.data;
                      // return a widget here (you have to return a widget to the builder)
                      return Text('Usuario ' + user);
                    }),
                Center(
                  child: RaisedButton(
                    child: Text('logout'),
                    onPressed: () => model.changeValue(),
                  ),
                )
              ],
            ),
          ));
    });
  }
}
