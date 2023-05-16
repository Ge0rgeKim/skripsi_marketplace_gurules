import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/edit_profile_guru.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';
import 'package:http/http.dart' as http;

class profile_guru extends StatefulWidget {
  int? index;
  profile_guru({super.key, required this.index});

  @override
  State<profile_guru> createState() => _profile_guruState(index);
}

class _profile_guruState extends State<profile_guru> {
  int? index;
  _profile_guruState(this.index);
  void initState() {
    print(index);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future getdataguru() async {
    var response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/user_guru/" + index.toString()));
    return json.decode(response.body);
  }

  final status = ["Online Onsite", "Online", "Onsite"];

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
            future: getdataguru(),
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
          future: getdataguru(),
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
                          height: 15,
                        ),
                        Container(
                          color: appbarColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            children: [
                              Icon(
                                Icons.book,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Mata Pelajaran",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data['data']['mata_pelajaran'],
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
                                Icons.location_city,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Lokasi",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    snapshot.data['data']['lokasi'],
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
                                Icons.online_prediction,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Status",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    status[snapshot.data['data']
                                        ['status_sesi']],
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
                                  return edit_profile_guru(data_profile: snapshot.data["data"]);
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
              return Text("data error");
            }
          },
        ),
      ),
    );
  }
}
