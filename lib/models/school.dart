import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SchoolItem {
  int id;
  String name;
  String desc;
  String address;
  String city;
  String state;
  String fees;
  String phone;
  String telegram;
  String website;
  String board;
  String standard;
  String medium;
  SchoolItem(
      {this.id,
      this.address,
      this.board,
      this.city,
      this.desc,
      this.fees,
      this.medium,
      this.name,
      this.phone,
      this.standard,
      this.state,
      this.telegram,
      this.website});

  SchoolItem.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.address = map['address'];
    this.board = map['board'];
    this.city = map['city'];
    this.desc = map['desc'];
    this.fees = map['fees'];
    this.medium = map['medium'];
    this.name = map['name'];
    this.phone = map['phone'];
    this.standard = map['standard'];
    this.state = map['state'];
    this.telegram = map['telegram'];
    this.website = map['website'];
  }
}

class School with ChangeNotifier {
  List<SchoolItem> _school = List<SchoolItem>();

  bool isFilter = false;

  List<SchoolItem> _filteredSchool = List<SchoolItem>();

  List<SchoolItem> get school {
    if (isFilter)
      return [..._filteredSchool];
    else
      return [..._school];
  }

  Future<void> getSchoolInCity(String city) async {
    final url =
        'https://wave-school-ad.herokuapp.com/school/list/${city.toLowerCase()}';
    try {
      _school.clear();
      final response = await http.get(url);
      final data = json.decode(response.body) as List;
      data.forEach((element) {
        _school.add(SchoolItem.fromMap(element));
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // Future<void> getSchoolDetails(int id) async {
  //   final url = 'https://wave-school-ad.herokuapp.com/school/details/$id';
  //   try {
  //     final response = await http.get(url);
  //     final data = json.decode(response.body) as List;

  //   } catch (e) {
  //     print(e);
  //   }
  // }

  void filterSchool(Map<String, List<String>> filters) {
    _filteredSchool.clear();
    isFilter = false;
    for (int i = 0; i < _school.length; i++) {
      if ((filters['board'].isEmpty ||
              filters['board'].contains(_school[i].board.toLowerCase())) &&
          (filters['medium'].isEmpty ||
              filters['medium'].contains(_school[i].medium.toLowerCase())) &&
          (filters['standard'].isEmpty ||
              filters['standard']
                  .contains(_school[i].standard.toLowerCase())) &&
          (int.parse(_school[i].fees) >= int.parse(filters['fees'][0]) &&
              int.parse(_school[i].fees) <= int.parse(filters['fees'][1]))) {
        _filteredSchool.add(school[i]);
      }
    }
    isFilter = true;
  }
}
