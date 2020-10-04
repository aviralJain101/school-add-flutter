import 'package:flutter/cupertino.dart';
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
}

class School with ChangeNotifier {
  List<SchoolItem> _school = List<SchoolItem>();
  // List<SchoolItem> _school = [
  //   SchoolItem(
  //       id: 1,
  //       address: 'testAddress1',
  //       board: 'CBSE',
  //       city: 'Kota',
  //       desc: 'Test Description',
  //       fees: '1000',
  //       name: 'Test 1',
  //       medium: 'English',
  //       standard: 'sr. sec.'),
  //   SchoolItem(
  //       id: 2,
  //       address: 'testAddress2',
  //       board: 'CBSE',
  //       city: 'Kota',
  //       desc: 'Test Description',
  //       fees: '2000',
  //       name: 'Test 2',
  //       medium: 'Hindi',
  //       standard: 'sr. sec.'),
  //   SchoolItem(
  //       id: 3,
  //       address: 'testAddress3',
  //       board: 'RBSE',
  //       city: 'Jaipur',
  //       desc: 'Test Description',
  //       fees: '1000',
  //       name: 'Test 3',
  //       medium: 'English',
  //       standard: 'sr. sec.'),
  //   SchoolItem(
  //       id: 4,
  //       address: 'testAddress4',
  //       board: 'ICSE',
  //       city: 'Udaipur',
  //       desc: 'Test Description',
  //       fees: '4000',
  //       name: 'Test 4',
  //       medium: 'English',
  //       standard: 'primary'),
  //   SchoolItem(
  //       id: 5,
  //       address: 'testAddress5',
  //       board: 'MPSE',
  //       city: 'Indore',
  //       desc: 'Test Description',
  //       fees: '3000',
  //       name: 'Test 5',
  //       medium: 'Hindi',
  //       standard: 'primary')
  // ];

  bool isFilter = false;

  List<SchoolItem> _filteredSchool = List<SchoolItem>();

  List<SchoolItem> get school {
    if (isFilter)
      return [..._filteredSchool];
    else
      return [..._school];
  }

  void getSchoolInCity(String city) async {
    final url = 'http://localhost:3000/school/list/${city.toLowerCase()}';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;
      _school = data;
      print(_school);
      print(data);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

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
