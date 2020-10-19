import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_ad/models/user.dart';
import 'package:school_ad/screens/home_screen.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = '/settings';

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    String city = Provider.of<Auth>(context, listen: false).city;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.blue[600], Colors.green])),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 23.0),
        ),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.save),
            onPressed: () {
              Provider.of<Auth>(context, listen: false).changeCity(city);
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: TextFormField(
          decoration: InputDecoration(labelText: 'Change City from: $city'),
          onChanged: (val) {
            city = val;
          },
        ),
      ),
    );
  }
}
