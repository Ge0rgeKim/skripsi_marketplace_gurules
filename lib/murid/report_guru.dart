import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/history_sesi_murid.dart';
import 'package:http/http.dart' as http;
import 'package:skripsi_c14190201/murid/home_murid.dart';

class report_guru extends StatefulWidget {
  final Map data_transaksi;
  report_guru({super.key, required this.data_transaksi});

  @override
  State<report_guru> createState() => _report_guruState(data_transaksi);
}

class _report_guruState extends State<report_guru> {
  final Map data_transaksi;
  _report_guruState(this.data_transaksi);

  void initState() {
    print(data_transaksi);
    super.initState();
  }

  void dispose() {
    isireportmurid.dispose();
    super.dispose();
  }

  TextEditingController isireportmurid = TextEditingController();

  String mataPelajaran = "";
  Future getdatasesi() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:8000/api/sesi/" +
        data_transaksi['id_sesi'].toString()));
    var response2 = await http.get(Uri.parse(
        "http://10.0.2.2:8000/api/user_guru/" +
            data_transaksi['id_guru'].toString()));
    mataPelajaran =
        json.decode(response2.body)['data']['mata_pelajaran'].toString();
    return json.decode(response.body);
  }

  Future savedata() async {
    final response =
        await http.post(Uri.parse("http://10.0.2.2:8000/api/report"), body: {
      "id_sesi": data_transaksi['id_sesi'].toString(),
      "id_murid": data_transaksi['id_murid'].toString(),
      "id_guru": data_transaksi['id_guru'].toString(),
      "keterangan": isireportmurid.text
    });
    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      return json.decode(response.body)['message'];
    }
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
            "Report",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 25,
              fontWeight: FontWeight.bold,
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
                              "ID Guru : " +
                                  snapshot.data['data']['id_guru'].toString(),
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 13,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Text("data error");
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      TextField(
                        controller: isireportmurid,
                        autofocus: true,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Laporan",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          save_report();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: buttoncolor,
                        ),
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future save_report() async {
    if (isireportmurid.text.isEmpty) {
      Alert(
        context: context,
        title: "Data belum lengkap",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else {
      savedata().then((value) {
        print(value);
        if (value == "success") {
          Alert(
            context: context,
            title: "Data Report Berhasil Ditambahkan",
            type: AlertType.success,
            buttons: [],
          ).show();
        } else {
          Alert(
            context: context,
            title: value,
            type: AlertType.error,
            buttons: [],
          ).show();
        }
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return history_sesi_murid(index_user: data_transaksi['id_murid']);
          },
        ),
      );
    }
  }
}
