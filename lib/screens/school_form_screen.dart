import 'package:flutter/material.dart';
import 'package:school_ad/models/school.dart';

class SchoolFormScreen extends StatelessWidget {
  static const routeName = '/school_form';
  Map<String, String> form = {
    'name': 'text',
    'father name': 'text',
    'mother name': 'text',
    'last class percentage': 'text',
    'class': 'text',
  };
  Map<String, dynamic> filledForm = Map<String, dynamic>();
  @override
  Widget build(BuildContext context) {
    final school = ModalRoute.of(context).settings.arguments as SchoolItem;
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.red, Colors.blue[800]])),
          ),
          title: Text(
            school.name + ' Form',
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 23.0),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: form.length,
                itemBuilder: (context, i) {
                  String key = form.keys.elementAt(i);
                  String value = form[key];
                  if (value.toLowerCase() == 'text') {
                    return Padding(
                      padding: EdgeInsets.only(top: 10, left: 5, right: 5),
                      child: TextFormField(
                        decoration: InputDecoration(
                          labelText: key,
                        ),
                        onChanged: (val) {
                          filledForm[key] = val;
                        },
                      ),
                    );
                  } else {
                    return Text('Not a text Field');
                  }
                },
              ),
            ),
            Divider(
              thickness: 5,
            ),
            RaisedButton(
              onPressed: () {
                //print(filledForm);
                Navigator.pop(context);
              },
              child: Text("Submit Form"),
              color: Colors.green,
            )
          ],
        ));
  }
}
