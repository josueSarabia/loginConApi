import 'package:flutter/material.dart';
import 'package:calculadoranotifier/model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:calculadoranotifier/widgets/singup.dart';
import 'dart:convert';

// Define a custom Form widget.
class SingIn extends StatefulWidget {
  @override
  SingInState createState() {
    return SingInState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class SingInState extends State<SingIn> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();
  String user;
  String password;
 _buildDialog( context,title, error){
    showDialog(
      barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
         
        shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(20.0)), //this right here
        title: Text(title),
        content: Text(error),
        );
  });
  }
  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Consumer<Model>(builder: (context, model, child) {
      return Scaffold(
          appBar: AppBar(
            title: Text('Sign in'),
          ),
          body: Form(
              key: _formKey,
              child: Column(children: <Widget>[
                // Add TextFormFields and RaisedButton here.
                TextFormField(
                  // The validator receives the text that the user has entered.
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                  validator: (value) {
                   
                      this.user = value;
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } 

                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    icon: Icon(Icons.lock),
                  ),
                  validator: (value) {
                    
                      this.password = value;
                      if (value.trim().isEmpty) {
                        return 'Password is required';
                      }  

                    return null;
                  },
                ),
                RaisedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                      final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signin',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': user,'password': password}),
    );

                      String userStorage = await model.getUser();
                      String passwordStorage = await model.getPassword();
                      if (response.statusCode == 200) {
                        model.email=user;
                      
                        model.login(json.decode(response.body)['token'],json.decode(response.body)['username']);
                      
                      }else{
                        _buildDialog(context, "Error credenciales", json.decode(response.body)['error']);

                      }
                    }
                  },
                  child: Text('Submit'),
                ),
                RaisedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SingUp()));
                  },
                  child: Text('SingUp'),
                )
              ])));
    });
  }
}
