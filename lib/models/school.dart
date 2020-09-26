import 'package:flutter/cupertino.dart';

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
  List<SchoolItem> _school = [
    SchoolItem(
      id: 1,
      address: 'testAddress1',
      board: 'CBSE',
      city: 'Kota',
      desc: 'Test Description',
      fees: '1000',
      name: 'Test 1',
      medium: 'English',      
    ),
    SchoolItem(
      id: 2,
      address: 'testAddress2',
      board: 'CBSE',
      city: 'Kota',
      desc: 'Test Description',
      fees: '2000',
      name: 'Test 2',
      medium: 'Hindi',
    ),
    SchoolItem(
      id: 3,
      address: 'testAddress3',
      board: 'RBSE',
      city: 'Jaipur',
      desc: 'Test Description',
      fees: '1000',
      name: 'Test 3',
      medium: 'English',
    ),
    SchoolItem(
      id: 4,
      address: 'testAddress4',
      board: 'ICSE',
      city: 'Udaipur',
      desc: 'Test Description',
      fees: '4000',
      name: 'Test 4',
      medium: 'English',
    ),
    SchoolItem(
      id: 5,
      address: 'testAddress5',
      board: 'MPSE',
      city: 'Indore',
      desc: 'Test Description',
      fees: '3000',
      name: 'Test 5',
      medium: 'Hindi',
    )
  ];

  List<SchoolItem> get school {
    return [..._school];
  }
}
