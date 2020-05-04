import 'package:flutter/material.dart';
import 'package:calculadoranotifier/model.dart';
import 'package:provider/provider.dart';
import 'package:calculadoranotifier/widgets/singup.dart';

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
                    labelText: 'User',
                  ),
                  validator: (value) {
                    model.getUser().then((user) {
                      this.user = value;
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      } else if (this.user != user) {
                        return 'Invalid Credentials';
                      }
                      return null;
                    });

                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                  validator: (value) {
                    model.getPassword().then((pass) {
                      this.password = value;
                      if (value.trim().isEmpty) {
                        return 'Password is required';
                      } else if (this.password != pass) {
                        return 'Invalid Credentials';
                      } 
                      return null;
                    });

                    return null;
                  },
                ),
                RaisedButton(
                  onPressed: () async {
                    // Validate returns true if the form is valid, otherwise false.
                    if (_formKey.currentState.validate()) {
                      // If the form is valid, display a snackbar. In the real world,
                      // you'd often call a server or save the information in a database.
                      /*Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));*/
                      String userStorage = await model.getUser();
                      String passwordStorage = await model.getPassword();
                      if (this.password == passwordStorage &&
                          this.user == userStorage) {
                        model.changeValue();
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
