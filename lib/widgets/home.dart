import 'package:flutter/material.dart';
import 'package:calculadoranotifier/model.dart';
import 'package:provider/provider.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dialogo.dart';

class Home extends StatelessWidget {
   Widget showD(){
     return Dialogo();
   }
   
  @override
  Widget build(BuildContext context) {
    return Consumer<Model>(builder: (context, model, child) {
      return Scaffold(
        floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          children: [
            SpeedDialChild(
          child: Icon(Icons.assignment, color: Colors.white),
          backgroundColor: Colors.deepOrange,
          onTap: () => showDialog(context: context,builder:  (BuildContext context) {
        return showD();
      },),
          label: 'Courses',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.deepOrangeAccent,
        ),
        SpeedDialChild(
          child: Icon(Icons.assignment_ind, color: Colors.white),
          backgroundColor: Colors.green,
          onTap: () => print('SECOND CHILD'),
          label: 'Profesores',
          labelStyle: TextStyle(fontWeight: FontWeight.w500),
          labelBackgroundColor: Colors.green,
        ),
          ],
        ),
          appBar: AppBar(
            title:  FutureBuilder(
                    future: model.getUser(),
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      if (!snapshot.hasData)
                        return Container(); // still loading
                      // alternatively use snapshot.connectionState != ConnectionState.done
                      final String user = snapshot.data;
                      // return a widget here (you have to return a widget to the builder)
                      return Text('Usuario: ' + user);
                    }),
            actions: <Widget>[
              InkWell(
                child:Icon(Icons.close) ,
                onTap:(){
                  model.changeValue();
                } ,
              )
              
            ],
            
          ),
          body: Container(
            child: ListView(
              children: model.cursos.map((curso){
                return Container(
                  child: Text(curso.name),
                );
              }).toList(),
            ),
          ));
    });
  }
}
