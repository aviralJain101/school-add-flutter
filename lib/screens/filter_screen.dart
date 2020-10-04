import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_ad/models/school.dart';
import 'package:school_ad/screens/home_screen.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  Map<String, List<String>> filters = Map<String, List<String>>();
  RangeValues _currentRangeValue = const RangeValues(0, 10000);
  Map<String, bool> _board = {'CBSE': false, 'RBSE': false};
  Map<String, bool> _standard = {'sr. sec.': false, 'primary': false};
  Map<String, bool> _medium = {'english': false, 'hindi': false};
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.blue[600], Colors.green])),
          ),
          title: const Text(
            'Filters',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 23.0),
          ),
          backgroundColor: Colors.white,
          actions: [
            FlatButton(
              child: Text('Clear Filter'),
              onPressed: () {},
            )
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ListView(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          height: 20,
                          child: Center(
                            child: Text(
                              'Fees',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          color: Colors.blueGrey[200],
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Row(
                          children: [
                            Container(
                                width: 40,
                                child: Text(_currentRangeValue.start
                                    .round()
                                    .toString())),
                            SizedBox(
                              width: 5,
                            ),
                            RangeSlider(
                              values: _currentRangeValue,
                              min: 0,
                              max: 10000,
                              divisions: 500,
                              labels: RangeLabels(
                                _currentRangeValue.start.round().toString(),
                                _currentRangeValue.end.round().toString(),
                              ),
                              onChanged: (RangeValues val) {
                                setState(() {
                                  _currentRangeValue = val;
                                });
                              },
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                                width: 40,
                                child: Text(
                                    _currentRangeValue.end.round().toString()))
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          height: 20,
                          child: Center(
                            child: Text(
                              'Board',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          color: Colors.blueGrey[200],
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: FilterChip(
                                selected: _board['CBSE'],
                                label: Text('CBSE'),
                                onSelected: (bool val) {
                                  setState(() {
                                    _board['CBSE'] = !_board['CBSE'];
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FilterChip(
                              selected: _board['RBSE'],
                              label: Text('RBSE'),
                              onSelected: (bool val) {
                                setState(() {
                                  _board['RBSE'] = !_board['RBSE'];
                                });
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          height: 20,
                          child: Center(
                            child: Text(
                              'Standard',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          color: Colors.blueGrey[200],
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: FilterChip(
                                selected: _standard['sr. sec.'],
                                label: Text('Sr. Sec.'),
                                onSelected: (bool val) {
                                  setState(() {
                                    _standard['sr. sec.'] =
                                        !_standard['sr. sec.'];
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FilterChip(
                              selected: _standard['primary'],
                              label: Text('Primary'),
                              onSelected: (bool val) {
                                setState(() {
                                  _standard['primary'] = !_standard['primary'];
                                });
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Container(
                          height: 20,
                          child: Center(
                            child: Text(
                              'Medium',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          color: Colors.blueGrey[200],
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: FilterChip(
                                selected: _medium['english'],
                                label: Text('English'),
                                onSelected: (bool val) {
                                  setState(() {
                                    _medium['english'] = !_medium['english'];
                                  });
                                },
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FilterChip(
                              selected: _medium['hindi'],
                              label: Text('Hindi'),
                              onSelected: (bool val) {
                                setState(() {
                                  _medium['hindi'] = !_medium['hindi'];
                                });
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              thickness: 5,
            ),
            RaisedButton(
              onPressed: () {
                List<String> _boardFilters = List<String>();
                List<String> _mediumFilters = List<String>();
                List<String> _standardFilters = List<String>();
                List<String> _feesFilters = List<String>();
                _board.forEach((key, value) {
                  if (value) _boardFilters.add(key.toLowerCase());
                });
                _medium.forEach((key, value) {
                  if (value) _mediumFilters.add(key.toLowerCase());
                });
                _standard.forEach((key, value) {
                  if (value) _standardFilters.add(key.toLowerCase());
                });
                _feesFilters.add(_currentRangeValue.start.round().toString());
                _feesFilters.add(_currentRangeValue.end.round().toString());
                filters['board'] = _boardFilters;
                filters['medium'] = _mediumFilters;
                filters['standard'] = _standardFilters;
                filters['fees'] = _feesFilters;
                Provider.of<School>(context, listen: false).filterSchool(filters);
                Navigator.of(context).pushNamedAndRemoveUntil(
                    HomeScreen.routeName, (route) => false);
              },
              child: Text("Apply Filters"),
              color: Colors.green,
            )
          ],
        ));
  }
}
