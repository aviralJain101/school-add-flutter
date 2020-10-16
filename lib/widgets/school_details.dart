import 'package:flutter/material.dart';
import 'package:school_ad/models/school.dart';

class SchoolDetails extends StatelessWidget {
  SchoolItem school;
  SchoolDetails(this.school);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            // Container(
            //   height: 200.0,
            //   color: Colors.grey[200],
            //   child: WidgetCarousel(
            //     pages: film.images
            //         .map((url) => FadeInImage(
            //               fit: BoxFit.fill,
            //               width: MediaQuery.of(context).size.width,
            //               image: NetworkImage(
            //                 url,
            //               ),
            //               placeholder:
            //                   AssetImage('assets/images/placeholder.png'),
            //             ))
            //         .toList(),
            //     dotSize: 4.0,
            //     dotSpacing: 15.0,
            //     dotColor: Theme.of(context).primaryColor,
            //     indicatorBgPadding: 5.0,
            //     dotBgColor: Colors.grey.withOpacity(0.0),
            //     autoplayDuration: Duration(seconds: 2),
            //   ),
            // ),
            // Container(
            //   padding: EdgeInsets.only(left: 4.0, right: 4.0),
            //   height: 50.0,
            //   child: ListView(
            //     scrollDirection: Axis.horizontal,
            //     children: film.actors
            //         .split(',')
            //         .map<Widget>(
            //           (f) => Padding(
            //             padding: EdgeInsets.symmetric(horizontal: 8.0),
            //             child: Chip(
            //               labelPadding: EdgeInsets.symmetric(horizontal: 8.0),
            //               label: Text(f,
            //                   style: TextStyle(
            //                     color: Colors.white,
            //                     fontFamily: Constant.fontMedium,
            //                   )),
            //               backgroundColor: Theme.of(context).primaryColor,
            //             ),
            //           ),
            //         )
            //         .toList(),
            //   ),
            // ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text(
                'Description - ${school.desc}',
                style: TextStyle(
                  color: Colors.grey[800]),
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Board - ${school.board}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0),
                  //   child: Text(
                  //     school.board,
                  //     style: TextStyle(
                  //         color: Colors.grey[500]),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              alignment: FractionalOffset.centerLeft,
              child: Wrap(
                children: <Widget>[
                  Text(
                    'Medium - ${school.medium}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0),
                  //   child: Text(
                  //     school.medium,
                  //     style: TextStyle(
                  //         color: Colors.grey[500]),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: <Widget>[
                  Text(
                    'Standard - ${school.standard}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0),
                  //   child: Text(
                  //     school.standard,
                  //     style: TextStyle(
                  //         color: Colors.grey[500]),
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(8.0),
              alignment: FractionalOffset.centerLeft,
              child: Wrap(
                children: <Widget>[
                  Text(
                    'Phone Number - ${school.phone}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.only(left: 10.0),
                  //   child: Wrap(
                  //     alignment: WrapAlignment.start,
                  //     children: <Widget>[
                  //       Text(
                  //         school.phone,
                  //         style: TextStyle(
                  //             color: Colors.grey[500]),
                  //       )
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.all(8.0),
            //   child: film.imdbRating != 'N/A'
            //       ? StarRating(
            //           color: Theme.of(context).primaryColor,
            //           rating: double.parse(film.imdbRating),
            //           starCount: 10,
            //         )
            //       : Container(),
            // )
          ],
        ),
      ),
    );
  }
}
