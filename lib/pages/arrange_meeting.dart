import 'dart:async';
import 'package:agucareer/models/user_model.dart';
import 'package:agucareer/values/colors.dart';
import 'package:agucareer/viewmodels/user_model.dart';
import 'package:agucareer/widgets/drawer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArrangeMeeting extends StatefulWidget {
  @override
  _ArrangeMeetingState createState() => _ArrangeMeetingState();
}

class _ArrangeMeetingState extends State<ArrangeMeeting> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedPart = 0;
  String _selectedName = "Kişi Seçiniz";
  String _selectedPlace = "Yer Seçiniz";
  String _selectedDate = "Tarih Seçiniz";
  String _selectedTime = "Saat Seçiniz";
  List<User> filteredUsers = List();
  final _debouncer = Debouncer(milliseconds: 500);

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    final UserModel _userModel = Provider.of<UserModel>(context);

    return Scaffold(
      key: _scaffoldKey,
      drawer: DrawerWidget().drawerMenu(context, _userModel),
      backgroundColor: AppColors.pembe.withOpacity(1),
      appBar: _getCustomAppBar(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Container(
              margin: EdgeInsets.only(right: 30, left: 30, top: 20),
              child: Column(
                children: <Widget>[
                  Spacer(flex: 1),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: screenSize.width / 2.5,
                          child: RaisedButton(
                            color: AppColors.acikMor.withOpacity(1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.lerp(Radius.circular(-45),
                                    Radius.circular(45), 1),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                _selectedPart = 0;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Spacer(flex: 1),
                                Icon(Icons.person, color: Colors.white),
                                Spacer(flex: 2),
                                Text(
                                  _selectedName,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(flex: 1),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: screenSize.width / 2.5,
                          child: RaisedButton(
                            color: AppColors.acikMor.withOpacity(1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomRight: Radius.lerp(
                                  Radius.circular(-45), Radius.circular(45), 1),
                            )),
                            onPressed: () {
                              setState(() {
                                _selectedPart = 1;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Spacer(flex: 1),
                                Text(
                                  _selectedPlace,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(flex: 2),
                                Icon(Icons.location_on, color: Colors.white),
                                Spacer(flex: 1),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 3,
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          width: screenSize.width / 2.5,
                          child: RaisedButton(
                            color: AppColors.acikMor.withOpacity(1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomLeft: Radius.lerp(
                                  Radius.circular(-45), Radius.circular(45), 1),
                            )),
                            onPressed: () {
                              setState(() {
                                _selectedPart = 2;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Spacer(flex: 1),
                                Icon(Icons.date_range, color: Colors.white),
                                Spacer(flex: 2),
                                Text(
                                  _selectedDate,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(flex: 1),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        SizedBox(
                          width: screenSize.width / 2.5,
                          child: RaisedButton(
                            color: AppColors.acikMor.withOpacity(1),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.only(
                              bottomRight: Radius.lerp(
                                  Radius.circular(-45), Radius.circular(45), 1),
                            )),
                            onPressed: () {
                              setState(() {
                                _selectedPart = 3;
                              });
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Spacer(flex: 1),
                                Text(
                                  _selectedTime,
                                  style: TextStyle(color: Colors.white),
                                ),
                                Spacer(flex: 2),
                                Icon(Icons.access_time, color: Colors.white),
                                Spacer(flex: 1),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Spacer(flex: 1),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      width: screenSize.width / 2,
                      child: RaisedButton(
                        color: AppColors.acikMor.withOpacity(1),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(40))),
                        onPressed: () {},
                        child: Text("AYARLA",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              color: AppColors.pembe.withOpacity(1),
                              child: Text(
                                "KİŞİ",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedPart = 0;
                                });
                              },
                              elevation: 0,
                            ),
                          ),
                          Expanded(
                            child: RaisedButton(
                              color: AppColors.pembe.withOpacity(1),
                              child: Text(
                                "YER",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedPart = 1;
                                });
                              },
                              elevation: 0,
                            ),
                          ),
                          Expanded(
                            child: RaisedButton(
                              color: AppColors.pembe.withOpacity(1),
                              child: Text(
                                "TARİH",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedPart = 2;
                                });
                              },
                              elevation: 0,
                            ),
                          ),
                          Expanded(
                            child: RaisedButton(
                              color: AppColors.pembe.withOpacity(1),
                              child: Text(
                                "SAAT",
                                style: TextStyle(color: Colors.white),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedPart = 3;
                                });
                              },
                              elevation: 0,
                            ),
                          ),
                        ],
                      )),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Builder(builder: (context) {
              if (_selectedPart == 0) {
                return _buildLoginBtn(context, _userModel);
              } else if (_selectedPart == 1) {
                return Container(
                  alignment: Alignment.center,
                  color: AppColors.koyuMor.withOpacity(1),
                  child: Text(
                    "YER",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else if (_selectedPart == 2) {
                return Container(
                  alignment: Alignment.center,
                  color: AppColors.koyuMor.withOpacity(1),
                  child: Text(
                    "TARİH",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              } else {
                return Container(
                  alignment: Alignment.center,
                  color: AppColors.koyuMor.withOpacity(1),
                  child: Text(
                    "SAAT",
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn(BuildContext context, UserModel _userModel) {
    Size screenSize = MediaQuery.of(context).size;
    return FutureBuilder<List<User>>(
        future: _userModel.getConnections(_userModel.user),
        builder: (context, data) {
          if (data.hasData) {
            filteredUsers = data.data;
            return Container(
                alignment: Alignment.center,
                color: AppColors.koyuMor.withOpacity(1),
                padding: EdgeInsets.only(top: 15),
                child: Column(
                  children: <Widget>[
                    Text("Birisini Seç",
                        style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'OpenSans')),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: screenSize.width / 1.7,
                          child: TextField(
                            cursorColor: Colors.grey,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hoverColor: Colors.white,
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.white.withOpacity(0.5),
                                ),
                                hintText: 'Seçmek istediğin ismin gir.',
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                )),
                            onChanged: (string) {
                              _debouncer.run(() {
                                setState(() {
                                  filteredUsers = data.data
                                      .where((u) => (u.name
                                              .toLowerCase()
                                              .contains(string.toLowerCase()) ||
                                          u.email
                                              .toLowerCase()
                                              .contains(string.toLowerCase())))
                                      .toList();
                                });
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: EdgeInsets.all(10.0),
                        itemCount: filteredUsers.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              margin: EdgeInsets.only(
                                  top: 10, bottom: 10, right: 15, left: 15),
                              color: Colors.white.withOpacity(0.2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(60.0),
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(top: 10, bottom: 10),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(
                                        data.data[index].profileURL),
                                  ),
                                  title: Text(
                                    filteredUsers[index].name,
                                    style: TextStyle(
                                        fontSize: 24.0,
                                        color: Colors.white,
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold),
                                  ),
                                  onTap: () {
                                    setState(() {
                                      _selectedName = filteredUsers[index].name;
                                    });

                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          _buildDialogName(
                                              context, _selectedName),
                                    );
                                  },
                                ),
                              ));
                        },
                      ),
                    ),
                  ],
                ));
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  Widget _buildDialogName(BuildContext context, String _selectedName) {
    return AlertDialog(
      content: Text(
        " ' " + _selectedName + " '   Kişisi Buluşma Ayarlanması İçin Seçildi.",
        style: TextStyle(color: AppColors.koyuMor.withOpacity(1), fontFamily: 'OpenSans')
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(30))),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          color: AppColors.koyuMor.withOpacity(1),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          textColor: Colors.white,
          child: Text('Tamam'),
        ),
      ],
    );
  }

  _getCustomAppBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(100),
      child: Container(
        alignment: Alignment.bottomCenter,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60),
          ),
          color: AppColors.koyuMor.withOpacity(1.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                IconButton(
                    padding: EdgeInsets.all(20),
                    icon: Icon(
                      Icons.menu,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () => _scaffoldKey.currentState.openDrawer()),
                IconButton(
                    padding: EdgeInsets.all(20),
                    icon: Icon(
                      Icons.notifications,
                      size: 28,
                      color: Colors.white,
                    ),
                    onPressed: () {}),
              ],
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            Text(
              "BULUŞMA  AYARLA",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}
