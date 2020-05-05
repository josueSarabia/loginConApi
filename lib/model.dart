import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Model extends ChangeNotifier {
  bool logged = false;
  String token;
  String username;
  String name;
  String email;
  Model(this.logged, {this.token, this.username, this.name, this.email});

  Future<String> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user') ?? '';
  }

  Future<void> setUser(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
  }

  Future<String> getPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('password') ?? '';
  }

  Future<void> setPassword(String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('password', password);
  }

  Future<bool> getState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('logged') ?? false;
  }

  Future<void> setState(bool logged) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('logged', logged);
  }

  Future<Model> dataUser(
      {String email, String password, String username, String name}) async {
    final http.Response response = await http.post(
      'https://movil-api.herokuapp.com/signup',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
        'username': username,
        'name': name
      }),
    );

    print('${response.body}');
    print('${response.statusCode}');
    if (response.statusCode == 200) {
      this.logged=true;
      print('${response.body}');
      setState(true);
      setUser(username);
      setPassword(password);
      notifyListeners();
      return Model.fromJson(json.decode(response.body));
    } else {   
      print("hola");  
        return throw  ( json.decode(response.body)['error']);
    }
  }

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      true,
      token: json['token'],
      username: json['username'],
      name: json['name'],
    );
  }
  void changeValue() {
    this.logged = !this.logged;
    print(this.logged);
    setState(this.logged);
    notifyListeners();
  }
}
