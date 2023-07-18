import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:http/http.dart' as http;

class detail_sesi_guru extends StatefulWidget {
  int? index_user;
  int? index_sesi;
  detail_sesi_guru(
      {super.key, required this.index_user, required this.index_sesi});

  @override
  State<detail_sesi_guru> createState() =>
      _detail_sesi_guruState(index_user, index_sesi);
}

class _detail_sesi_guruState extends State<detail_sesi_guru> {
  int? index_user;
  int? index_sesi;
  _detail_sesi_guruState(this.index_user, this.index_sesi);

  void initState() {
    print(index_user);
    print(index_sesi);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  String mataPelajaran = "";
  String lokasiGuru = "";
  int statusSesi = 0;
  final status = ["Online Onsite", "Online", "Onsite"];
  // Future getdatasesi() async {
  //   var response = await http
  //       .get(Uri.parse("http://10.0.2.2:8000/api/sesi/" + index_sesi.toString()));
  //   var response2 = await http.get(Uri.parse(
  //       "http://10.0.2.2:8000/api/user_guru/" +
  //           json.decode(response.body)['data']['id_guru'].toString()));
  //   mataPelajaran =
  //       json.decode(response2.body)['data']['mata_pelajaran'].toString();
  //   lokasiGuru = json.decode(response2.body)['data']['lokasi'].toString();
  //   statusSesi = json.decode(response2.body)['data']['status_sesi'];
  //   return json.decode(response.body);
  // }

  Future getdatasesi() async {
    var response = await http.get(
      Uri.parse(
        "https://literasimilenial.net/george/public/api/sesi/" +
            index_sesi.toString(),
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
    lokasiGuru = json.decode(response2.body)['data']['lokasi'].toString();
    statusSesi = int.parse(json.decode(response2.body)['data']['status_sesi']);
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
            "Detail Sesi",
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
                  FutureBuilder(
                    future: getdatasesi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          children: [
                            Column(
                              children: [
                                Text(
                                  "ID Sesi : " +
                                      snapshot.data['data']['id'].toString(),
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
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
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id',
                                          symbol: "Rp. ",
                                          decimalDigits: 0)
                                      .format(
                                    int.parse(
                                        snapshot.data['data']['nominal_saldo']),
                                  ),
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Text(
                                  int.parse(snapshot.data['data']
                                              ['status_sesi']) ==
                                          1
                                      ? "Sesi sudah di booking"
                                      : "Sesi belum di booking",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      lokasiGuru,
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
                                      status[statusSesi].toString(),
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
                            Column(
                              children: [
                                Text(
                                  "Keterangan",
                                  style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  snapshot.data['data']['keterangan'],
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
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
