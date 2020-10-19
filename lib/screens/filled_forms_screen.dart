import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_ad/models/filled_form.dart';
import 'package:school_ad/models/user.dart';

class FilledFormsScreen extends StatefulWidget {
  static const routeName = '/filled_forms';
  @override
  _FilledFormsScreenState createState() => _FilledFormsScreenState();
}

class _FilledFormsScreenState extends State<FilledFormsScreen> {
  bool isLoading = false;

  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      String token = Provider.of<Auth>(context, listen: false).token;
      Provider.of<FilledForms>(context, listen: false)
          .getFilledFormsByUser(token)
          .then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    List<FilledFormItem> filledForms =
        Provider.of<FilledForms>(context).filledForm;
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.blue[600], Colors.green])),
          ),
          title: const Text(
            'Filled Forms',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 23.0),
          ),
        ),
        body: isLoading ? Center(child: CircularProgressIndicator(),) : Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.builder(
            itemCount: filledForms.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(filledForms[i].schoolName),
              subtitle: Text('Class: ${filledForms[i].clas.toString()}'),
              leading: filledForms[i].approval == -1 ? Icon(Icons.cancel) : filledForms[i].approval == 0 ? Icon(Icons.cloud_upload) : Icon(Icons.check_box),
            ),
          ),
        ));
  }
}
