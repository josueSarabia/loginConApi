import 'package:flutter/material.dart';
import 'package:calculadoranotifier/model.dart';
import 'package:provider/provider.dart';


// Define a custom Form widget.
class SingUp extends StatefulWidget {
  @override
  SingUpState createState() {
    return SingUpState();
  }
}

// Define a corresponding State class.
// This class holds data related to the form.
class SingUpState extends State<SingUp> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a `GlobalKey<FormState>`,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

 
  String password;
  String username;
  String name;
  String email;
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
                title: Text('Sign up'),
              ),
              body: Form(
                  key: _formKey,
                  child: Column(children: <Widget>[
                    // Add TextFormFields and RaisedButton here.
                    TextFormField(
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                        icon: Icon(Icons.account_circle),
                        labelText: 'Name',
                      ),
                      validator: (value) {
                        this.name = value;
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        print(value);
                        model.setUser(value);
                        return null;
                      },
                    ),
                    TextFormField(
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                         icon: Icon(Icons.people),
                        labelText: 'User name',
                      ),
                      validator: (value) {
                        this.username = value;
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        print(value);
                        model.setUser(value);
                        return null;
                      },
                    ),
                     TextFormField(
                       keyboardType: TextInputType.emailAddress,
                      // The validator receives the text that the user has entered.
                      decoration: const InputDecoration(
                         icon: Icon(Icons.email),
                        labelText: 'Email',
                      ),
                      validator: (value) {
                        this.email = value;
                        if (value.isEmpty) {
                          return 'Please enter some text';
                        }
                        print(value);
                        model.setUser(value);
                        return null;
                      },
                    ),
                    TextFormField(
                      obscureText: true,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.lock),
                        labelText: 'Password',
                      ),
                      validator: (value){
                        this.password = value;
                        if (value.trim().isEmpty) {
                          return 'Password is required';
                        }
                        print(value);
                        model.setPassword(value);
                        return null;
                      },
                    ),
                    RaisedButton(
                      onPressed: ()   {
                        // Validate returns true if the form is valid, otherwise false.
                        if (_formKey.currentState.validate()) {
                          // If the form is valid, display a snackbar. In the real world,
                          // you'd often call a server or save the information in a database.
                          /*Scaffold.of(context)
                    .showSnackBar(SnackBar(content: Text('Processing Data')));*/
                          model.dataUser(email: email,username: username,name: name,password: password).then((model)   {
     
       print("creado");
}).catchError((error) {
        return _buildDialog(context, "Error", error.toString());
}).timeout(Duration(seconds: 10), onTimeout: () {
        return _buildDialog(context, "Error", "Timeout > 10secs");
});

                         
                        }
                      },
                      child: Text('Submit'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('SingIn'),
                    )
                  ])));
    });
  }
}