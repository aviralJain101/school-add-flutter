import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_ad/models/filled_form.dart';
import 'package:school_ad/screens/filled_forms_screen.dart';
import 'package:school_ad/screens/filter_screen.dart';
import 'package:school_ad/screens/school_detail_screen.dart';
import 'package:school_ad/screens/school_form_screen.dart';
import 'package:school_ad/screens/settings_screen.dart';

import 'models/form.dart';
import 'models/school.dart';
import 'models/user.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: School()),
        ChangeNotifierProvider.value(value: Forms()),
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: FilledForms()),
      ],
      child: Consumer<Auth>(
        builder:(context, auth,_) => MaterialApp(
          title: 'School Ad',
          debugShowCheckedModeBanner: false,
          home: auth.isAuth ?  HomeScreen() : FutureBuilder(
            future: auth.tryAutoLogin(),
            builder: (context, snapshot)=>snapshot.connectionState == ConnectionState.waiting ?
              Center(child: CircularProgressIndicator(),) : AuthScreen(),
          ),
          routes: {
            HomeScreen.routeName: (c)=> HomeScreen(),
            SchoolDetailScreen.routeName: (c)=> SchoolDetailScreen(),
            SchoolFormScreen.routeName: (c)=> SchoolFormScreen(),
            FilterScreen.routeName: (c)=> FilterScreen(),
            SettingsScreen.routeName: (c) => SettingsScreen(),
            FilledFormsScreen.routeName: (c)=> FilledFormsScreen(),
          },
        ),
      ),
    );
  }
}