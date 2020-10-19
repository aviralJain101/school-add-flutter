import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_ad/models/user.dart';
import 'package:school_ad/screens/filled_forms_screen.dart';
import 'package:school_ad/screens/settings_screen.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello there'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.school),
            title: Text('Schools'),
            onTap: () => Navigator.of(context).pushReplacementNamed('/'),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Settings'),
            onTap: () =>
                Navigator.of(context).pushNamed(SettingsScreen.routeName),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.shopping_cart),
            title: Text('Filled Forms'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushNamed(FilledFormsScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Logout'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushReplacementNamed('/');
                Provider.of<Auth>(context, listen: false).logOut();
              })
        ],
      ),
    );
  }
}
