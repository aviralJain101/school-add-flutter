import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_ad/models/filled_form.dart';
import 'package:school_ad/models/form.dart';
import 'package:school_ad/models/school.dart';
import 'package:school_ad/models/user.dart';

class SchoolFormScreen extends StatelessWidget {
  static const routeName = '/school_form';
  Map<String, dynamic> form = Map<String, dynamic>();
  Map<String, dynamic> filledFormData = Map<String, dynamic>();
  @override
  Widget build(BuildContext context) {
    final formId = ModalRoute.of(context).settings.arguments as int;
    final forms =
        Provider.of<Forms>(context, listen: false).getFormById(formId);
    form = forms.formData;
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.red, Colors.blue[800]])),
          ),
          title: Text(
            forms.schoolName + ' ' + forms.clas.toString() + ' Form',
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
                          filledFormData[key] = val;
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
                FilledFormItem filledForm = FilledFormItem(
                  approval: 0,
                  formData: filledFormData,
                  clas: forms.clas,
                  schoolName: forms.schoolName,
                );
                print(filledForm.formData);
                Navigator.pop(context);
              },
              child: Text("Submit Form"),
              color: Colors.green,
            )
          ],
        ));
  }
}
