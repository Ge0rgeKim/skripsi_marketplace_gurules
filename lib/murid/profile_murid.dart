import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/edit_profile_murid.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';
import 'package:http/http.dart' as http;

class profile_murid extends StatefulWidget {
  int? index_user;
  profile_murid({super.key, required this.index_user});

  @override
  State<profile_murid> createState() => _profile_muridState(index_user);
}

class _profile_muridState extends State<profile_murid> {
  int? index_user;
  _profile_muridState(this.index_user);
  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  // Future getdatamurid() async {
  //   var response = await http.get(Uri.parse(
  //       "http://10.0.2.2:8000/api/user_murid/" + index_user.toString()));
  //   return json.decode(response.body);
  // }

  Future getdatamurid() async {
    var response = await http.get(
      Uri.parse(
        "https://literasimilenial.net/george/public/api/user_murid/" +
            index_user.toString(),
      ),
    );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    String username = "";
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Skripsi c14190201",
      home: Scaffold(
        backgroundColor: containerColor,
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: FutureBuilder(
            future: getdatamurid(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                username = snapshot.data['data']['username'];
                return Container(
                  padding: EdgeInsets.fromLTRB(10, 15, 10, 15),
                  child: Row(
                    children: [
                      Icon(
                        SkripsiIcon.user,
                        size: 25,
                        color: Colors.black,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Welcome, $username",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Text("data error");
              }
            },
          ),
          centerTitle: true,
          toolbarHeight: 75,
          // leadingWidth: 65,
          // titleSpacing: 0,
          elevation: 0,
        ),
        body: FutureBuilder(
          future: getdatamurid(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Scrollbar(
                trackVisibility: true,
                child: SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
                    child: Column(
                      children: [
                        Container(
                          color: appbarColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.people,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "ID",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data['data']['id'].toString(),
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: appbarColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.perm_identity,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Username",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data['data']['username'],
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: appbarColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.email,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data['data']['email'],
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          color: appbarColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.key,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Password",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data['data']['password'],
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return edit_profile_murid(
                                      data_profile: snapshot.data["data"]);
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: buttoncolor,
                          ),
                          child: Text(
                            "Edit Data",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Text("Data Error");
            }
          },
        ),
      ),
    );
  }
}
