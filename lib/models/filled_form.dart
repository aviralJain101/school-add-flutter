import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FilledFormItem {
  int id;
  Map<String, dynamic> formData;
  String feePaid;
  int approval;
  int clas;
  String schoolName;
  FilledFormItem(
      {this.approval,
      this.feePaid,
      this.formData,
      this.id,
      this.clas,
      this.schoolName});
  FilledFormItem.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.formData = map['formData'];
    this.feePaid = map['feePaid'];
    this.approval = map['approval'];
    this.clas = map['clas'];
    this.schoolName = map['schoolName'];
  }
}

class FilledForms with ChangeNotifier {
  List<FilledFormItem> _filledForm = List<FilledFormItem>();

  List<FilledFormItem> get filledForm {
    return [..._filledForm];
  }

  FilledFormItem getFilledFormById(int id) {
    for (int i = 0; i < _filledForm.length; i++) {
      if (_filledForm[i].id == id) return _filledForm[i];
    }
    return null;
  }

  Future<void> getFilledFormsByUser(String token) async {
    final url = 'https://wave-school-ad.herokuapp.com/filledForm/user';
    try {
      final response =
          await http.get(url, headers: {'Authorization': 'Bearer $token'});
      final data = json.decode(response.body) as List;
      data.forEach((element) {
        _filledForm.add(FilledFormItem.fromMap(element));
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // Future<void> addFilledForm(
  //     FilledFormItem filledForm, String token, int formId) async {
  //   final url = 'https://wave-school-ad.herokuapp.com/filledForm/$formId';
  //   try {
  //     final response = await http
  //         .post(url, headers: {'Authorization': 'Bearer $token'}, body: {});
  //   } catch (e) {
  //     print(e);
  //   }
  // }
}
