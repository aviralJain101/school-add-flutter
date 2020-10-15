import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_ad/models/form.dart';
import 'package:school_ad/screens/school_form_screen.dart';

class FormClassScreen extends StatefulWidget {
  int schoolId;
  FormClassScreen(this.schoolId);
  @override
  _FormClassScreenState createState() => _FormClassScreenState();
}

class _FormClassScreenState extends State<FormClassScreen> {
  bool isLoading = false;

  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Forms>(context, listen: false)
          .getFormsOfSchool(widget.schoolId)
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
    final forms = Provider.of<Forms>(context).form;
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.blue[600], Colors.green])),
          ),
          title: const Text(
            'Available Classes',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 23.0),
          ),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                  itemCount: forms.length,
                  itemBuilder: (context, index) => ListTile(
                    title: Text(forms[index].clas.toString()),
                    onTap: () {
                      Navigator.of(context).pushNamed(
                          SchoolFormScreen.routeName,
                          arguments: forms[index].id);
                    },
                  ),
                ),
              ));
  }
}
