import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:http/http.dart' as http;

class detail_penilaian extends StatefulWidget {
  final Map data_review;
  detail_penilaian({super.key, required this.data_review});

  @override
  State<detail_penilaian> createState() => _detail_penilaianState(data_review);
}

class _detail_penilaianState extends State<detail_penilaian> {
  final Map data_review;
  _detail_penilaianState(this.data_review);
  void initState() {
    print(data_review);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  String mataPelajaran = "";
  // Future getdatasesi() async {
  //   var response = await http.get(Uri.parse(
  //       "http://10.0.2.2:8000/api/sesi/" + data_review['id_sesi'].toString()));
  //   var response2 = await http.get(Uri.parse(
  //       "http://10.0.2.2:8000/api/user_guru/" +
  //           json.decode(response.body)['data']['id_guru'].toString()));
  //   mataPelajaran =
  //       json.decode(response2.body)['data']['mata_pelajaran'].toString();
  //   return json.decode(response.body);
  // }

  Future getdatasesi() async {
    var response = await http.get(
      Uri.parse(
        "https://literasimilenial.net/george/public/api/sesi/" +
            data_review['id_sesi'].toString(),
      ),
    );
    var response2 = await http.get(
      Uri.parse(
        "https://literasimilenial.net/george/public/api/user_guru/" +
            json.decode(response.body)['data']['id_guru'].toString(),
      ),
    );
    mataPelajaran =
        json.decode(response2.body)['data']['mata_pelajaran'].toString();
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
            "Detail Penilaian",
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
        body: Scrollbar(
          trackVisibility: true,
          child: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.fromLTRB(20, 30, 20, 30),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        "ID Sesi : " + data_review['id_sesi'].toString(),
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      FutureBuilder(
                        future: getdatasesi(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return Column(
                              children: [
                                Text(
                                  mataPelajaran,
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 13,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      snapshot.data['data']['tanggal_sesi'],
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      " | ",
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 13,
                                      ),
                                    ),
                                    Text(
                                      snapshot.data['data']['waktu_sesi'],
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          } else {
                            return Text("data error");
                          }
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ID Murid : " + data_review['id_murid'].toString(),
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            " | ",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 13,
                            ),
                          ),
                          Text(
                            "Nilai : " +
                                data_review['penilaian_sesi'].toString(),
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    data_review['komentar_sesi'],
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
