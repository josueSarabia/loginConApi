import 'package:flutter/material.dart';
import 'package:calculadoranotifier/model.dart';
import 'package:provider/provider.dart';
 
class Dialogo extends StatefulWidget {
 
 
  @override
  _DialogoState createState() => _DialogoState();
}
class _DialogoState extends State<Dialogo> {
  
   
    
   String _dropSelected = "DEFAULT";
    

   void se(value) => setState(() {
              _dropSelected = value;
              print(_dropSelected);
            });
 
 
  @override
  Widget build(BuildContext context) {
      var model = Provider.of<Model>(context);
    return AlertDialog(
      actions: <Widget>[
        FlatButton(onPressed:(){  

          print(model.name);
          print(model.username);
          model.addcourses();
            Navigator.of(context).pop(true);}, child: Text("Agregar")),
        FlatButton(onPressed: (){
        

          Navigator.of(context).pop(null);
          }, child: Text("Cancelar"))
      ],
    
      
      title: Text(
        'New course',
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 20.0),
      ),
      content: Container( alignment: Alignment.center, width: 320, height: 20 ,child: Column(children: <Widget>[  
      
         ])
      ));
      
      }
}
