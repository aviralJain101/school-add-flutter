import 'package:flutter/material.dart';
import 'package:school_ad/models/school.dart';
import 'package:school_ad/screens/form_class_screen.dart';
import 'package:school_ad/screens/school_form_screen.dart';
import 'package:school_ad/widgets/school_details.dart';

class SchoolDetailScreen extends StatelessWidget {
  static const routeName = '/school_detail';
  @override
  Widget build(BuildContext context) {
    final school = ModalRoute.of(context).settings.arguments as SchoolItem;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [Colors.red, Colors.blue[800]])),
        ),
        title: Text(
          school.name,
          style: TextStyle(
              color: Colors.green, fontWeight: FontWeight.bold, fontSize: 23.0),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Fill Form'),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      FormClassScreen(school.id)));
        },
        backgroundColor: Colors.green,
        hoverColor: Colors.blue,
        tooltip: 'Admission form for ${school.name}',
      ),
      body: SchoolDetails(school)
    );
  }
}
