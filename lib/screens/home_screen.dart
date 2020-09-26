import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_ad/models/school.dart';
import 'package:school_ad/widgets/app_drawer.dart';
import 'package:school_ad/widgets/home_list.dart';
import 'package:school_ad/widgets/search.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SchoolItem> school = Provider.of<School>(context,listen: false).school;
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient:
                  LinearGradient(colors: [Colors.blue[600], Colors.green])),
        ),
        title: const Text(
          'SchoolAd',
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 23.0),
        ),
        actions: <Widget>[
          FlatButton(
            child: Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: Search(school));
            },
          ),
          FlatButton(
            child: Icon(Icons.filter),
            onPressed: () {},
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: HomeList(),
    );
  }
}
