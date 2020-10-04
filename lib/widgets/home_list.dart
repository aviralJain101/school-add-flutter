import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_ad/models/school.dart';
import 'package:school_ad/screens/school_detail_screen.dart';

class HomeList extends StatelessWidget {
  List<SchoolItem> school;
  @override
  Widget build(BuildContext context) {
    school = Provider.of<School>(context, listen: false).school;
    return Container(
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: ListView.builder(
          itemCount: school.length,
          itemBuilder: (context, i) {
            return Padding(
              padding: EdgeInsets.only(top: 10),
              child: ListTile(
                title: Text(school[i].name),
                subtitle: Text(school[i].board),
                trailing: Text(school[i].city),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    SchoolDetailScreen.routeName,
                    arguments: school[i],
                  );
                }
              ),
            );
          },
        ),
      ),
    );
  }
}
