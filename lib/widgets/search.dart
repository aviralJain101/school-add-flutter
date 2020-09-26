import 'package:flutter/material.dart';
import 'package:school_ad/models/school.dart';
import 'package:school_ad/screens/school_detail_screen.dart';

class Search extends SearchDelegate {
  List<SchoolItem> school;
  Search(this.school);
  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  String selectedResult;
  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedResult),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<SchoolItem> suggestionSchool = List<SchoolItem>();
    if (query.isNotEmpty) {
      suggestionSchool.addAll(school
          .where((element) => element.name.toLowerCase().startsWith(query.toLowerCase()))
          .toList());
    }
    if (query.isEmpty) {
      return Center(
        child: Text('Please search for a school'),
      );
    } else if (suggestionSchool.isEmpty) {
      return Center(
        child: Text('No School Found')
      );
    } else {
      return ListView.builder(
        itemCount: suggestionSchool.length,
        itemBuilder: (context, index) {
          return ListTile(
            onTap: () {
              Navigator.of(context).pushNamed(
                SchoolDetailScreen.routeName,
                arguments: suggestionSchool[index],
              );
            },
            title: Text(suggestionSchool[index].name),
          );
        },
      );
    }
  }
}
