import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_ad/screens/school_detail_screen.dart';

import 'models/school.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: School()),
      ],
      child: MaterialApp(
        title: 'School Ad',
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        routes: {
          SchoolDetailScreen.routeName: (c)=> SchoolDetailScreen(),
        },
      ),
    );
  }
}