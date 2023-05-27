import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/sesi_guru.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';
import 'package:http/http.dart' as http;

class history_guru extends StatefulWidget {
  int? index_user;
  history_guru({super.key, required this.index_user});

  @override
  State<history_guru> createState() => _history_guruState(index_user);
}

class _history_guruState extends State<history_guru> {
  int? index_user;
  _history_guruState(this.index_user);
  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  // Future getdatatransesi() async {
  //   var response = await http.get(Uri.parse(
  //       "http://10.0.2.2:8000/api/transaksi_sesi/murid/" +
  //           index_user.toString()));
  //   return json.decode(response.body);
  // }

  Future getdatatransesi() async {
    var response = await http.get(
      Uri.parse(
        "https://literasimilenial.net/george/public/api/transaksi_sesi/murid/" +
            index_user.toString(),
      ),
    );
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Skripsi c14190201",
      home: Scaffold(
        backgroundColor: containerColor,
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: Text(
            "History User Guru",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          leading: IconButton(
            onPressed: () => {
              Navigator.of(context).pop(),
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
          centerTitle: true,
          toolbarHeight: 75,
          // leadingWidth: 65,
          // titleSpacing: 0,
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(5, 30, 5, 30),
          child: Column(
            children: [
              FutureBuilder(
                future: getdatatransesi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, index) {
                          if (snapshot.data['data'][index]['id_sesi'] != '0') {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          SkripsiIcon.chalkboard_teacher,
                                          size: 25,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "ID Sesi : " +
                                              snapshot.data['data'][index]
                                                      ['id_sesi']
                                                  .toString(),
                                          style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          " | ",
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 15,
                                          ),
                                        ),
                                        Text(
                                          "ID Guru : " +
                                              snapshot.data['data'][index]
                                                      ['id_guru']
                                                  .toString(),
                                          style: TextStyle(
                                              fontFamily: "Roboto",
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return sesi_guru(
                                                  data_guru: snapshot
                                                      .data['data'][index]);
                                            },
                                          ),
                                        );
                                      },
                                      child: Icon(
                                        Icons.arrow_right_outlined,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    );
                  } else {
                    return Text("data error");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
