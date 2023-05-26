import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/detail_sesi_murid.dart';
import 'package:skripsi_c14190201/murid/report_guru.dart';
import 'package:skripsi_c14190201/murid/review_guru.dart';
import 'package:http/http.dart' as http;

class history_sesi_murid extends StatefulWidget {
  int? index_user;
  history_sesi_murid({super.key, required this.index_user});

  @override
  State<history_sesi_murid> createState() =>
      _history_sesi_muridState(index_user);
}

class _history_sesi_muridState extends State<history_sesi_murid> {
  int? index_user;
  _history_sesi_muridState(this.index_user);
  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future getdatatransesi() async {
    var response = await http.get(Uri.parse(
        "http://10.0.2.2:8000/api/transaksi_sesi/murid/" +
            index_user.toString()));
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
            "History Sesi",
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
                    return Text(
                      "Total Sesi : " +
                          (snapshot.data['data'].length - 1).toString(),
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20,
                      ),
                    );
                  } else {
                    return Text("data error");
                  }
                },
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: getdatatransesi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, index) {
                          if (snapshot.data['data'][index]['id_sesi'] != 0) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      snapshot.data['data'][index]
                                          ['id_transaksi'],
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      "ID Sesi : " +
                                          snapshot.data['data'][index]['id_sesi'].toString() ,
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return review_guru(
                                              data_transaksi:
                                                  snapshot.data['data'][index]);
                                        },
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: buttoncolor,
                                  ),
                                  child: Text(
                                    "Review",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return report_guru(
                                              data_transaksi:
                                                  snapshot.data['data'][index]);
                                        },
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: buttoncolor,
                                  ),
                                  child: Text(
                                    "Report",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return detail_sesi_murid(
                                            index_user: index_user,
                                            index_sesi: snapshot.data['data']
                                                [index]['id_sesi'],
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: buttoncolor,
                                  ),
                                  child: Text(
                                    "Detail",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
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
