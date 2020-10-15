import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FormItem {
  int id;
  String schoolName;
  int clas;
  String initialCharge;
  int availableSeats;
  Map<String, dynamic> formData;
  FormItem(
      {this.availableSeats,
      this.clas,
      this.formData,
      this.id,
      this.initialCharge,
      this.schoolName});

  FormItem.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.schoolName = map['schoolName'];
    this.clas = map['clas'];
    this.initialCharge = map['initialCharge'];
    this.availableSeats = map['availableSeats'];
    this.formData = map['formData'];
  }
}

class Forms with ChangeNotifier {
  List<FormItem> _form = List<FormItem>();

  List<FormItem> get form {
    _form.sort((a, b) => a.clas.compareTo(b.clas));
    return [..._form];
  }

  Future<void> getFormsOfSchool(int schoolId) async {
    final url = 'https://wave-school-ad.herokuapp.com/school/form/$schoolId';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as List;
      data.forEach((element) {
        _form.add(FormItem.fromMap(element));
      });
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  FormItem getFormById(int id) {
    for (int i = 0; i < _form.length; i++) {
      if (_form[i].id == id) {
        return _form[i];
      }
    }
    return null;
  }
}
