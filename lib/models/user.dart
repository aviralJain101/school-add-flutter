import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class User {
  int id;
  String email;
  String phone;
  String city;
  String name;
  String state;
}

class Auth with ChangeNotifier {
  String _token;
  String _city;

  bool get isAuth {
    return _token != null;
  }

  String get token {
    return _token;
  }

  String get city {
    return _city;
  }

  Future<void> changeCity(String city) async {
    _city = city;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('city', _city);
  }

  Future<void> signUp(
      String email, String password, String userName, String city) async {
    const url = 'https://wave-school-ad.herokuapp.com/user/register';
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode({
            "name": userName,
            "email": email,
            "password": password,
            "city": city
          }));
      final responseData = json.decode(response.body);
      _token = responseData['token'];
      _city = city;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _token);
      prefs.setString('city', _city);
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<void> login(String email, String password, String city) async {
    const url = 'https://wave-school-ad.herokuapp.com/user/login';
    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json
              .encode({"email": email, "password": password, "city": city}));
      final responseData = json.decode(response.body);
      _token = responseData['token'];
      _city = city;
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _token);
      prefs.setString('city', _city);
    } catch (error) {
      print(error);
      throw (error);
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('token')) return false;
    _token = prefs.getString('token');
    _city = prefs.getString('city');
    notifyListeners();
    return true;
  }

  Future<void> logOut() async {
    _token = null;
    _city = null;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');
    prefs.remove('city');
  }
}
