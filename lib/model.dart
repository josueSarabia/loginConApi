import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Model extends ChangeNotifier {
  bool _logged ;
  String _user;
  String _password;

  
  Model(bool logged) {
    _logged = logged; 
  }

  Future<String> getUser() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('user') ?? '';
  }

  Future<void> setUser(String user) async{
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

  void dataUser(String user, String password){
    _user = user;
    _password = password;
    _logged = !_logged;
    setState(_logged);
    setUser(_user);
    setPassword(_password);
    notifyListeners();
  }

  void changeValue(){
    _logged = !_logged;
    print(_logged);
    setState(_logged);
    notifyListeners();
  }
}