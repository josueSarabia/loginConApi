import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calculadoranotifier/model.dart';
import 'package:calculadoranotifier/widgets/sigin.dart';
import 'package:calculadoranotifier/widgets/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Model>(
        //      <--- ChangeNotifierProvider
        create: (context) => Model(false),
        child: Consumer<Model>(
            //                  <--- Consumer
            builder: (context, model, child) {
          return MaterialApp(home: span(model));
        }));
  }

  Widget span(Model model) {
    return FutureBuilder(
        future: model.getState(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) return Container(); // still loading
          // alternatively use snapshot.connectionState != ConnectionState.done
          final bool looged = snapshot.data;
          // return a widget here (you have to return a widget to the builder)
          return looged ? SingIn() : Home();
        });
  }
}
