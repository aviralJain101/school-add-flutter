import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: <Widget>[
        AppBar(
          title: Text('Hello there'),
            automaticallyImplyLeading: false,
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shop),
          title: Text('Shop'),
          onTap: ()=>Navigator.of(context).pushReplacementNamed('/'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.settings),
          title: Text('Settings'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.shopping_cart),
          title: Text('Filled Forms'),
        ),
        Divider(),
        ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text('Logout'),
          onTap: (){
            Navigator.of(context).pop();
            Navigator.of(context).pushReplacementNamed('/');
            //Provider.of<Auth>(context,listen: false).logOut();
          }
        )
      ],),
    );
  }
}