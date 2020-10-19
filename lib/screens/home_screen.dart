import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_ad/models/school.dart';
import 'package:school_ad/models/user.dart';
import 'package:school_ad/screens/filter_screen.dart';
import 'package:school_ad/widgets/app_drawer.dart';
import 'package:school_ad/widgets/home_list.dart';
import 'package:school_ad/widgets/search.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  bool isInit = true;

  @override
  void didChangeDependencies() {
    if (isInit) {
      setState(() {
        isLoading = true;
      });
      String city = Provider.of<Auth>(context, listen: false).city;
      Provider.of<School>(context, listen: false)
          .getSchoolInCity(city.toLowerCase())
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
    List<SchoolItem> school = Provider.of<School>(context).school;
    return isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.blue[600], Colors.green])),
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
                  onPressed: () {
                    Navigator.of(context).pushNamed(FilterScreen.routeName);
                  },
                ),
              ],
            ),
            drawer: AppDrawer(),
            body: HomeList(),
          );
  }
}
