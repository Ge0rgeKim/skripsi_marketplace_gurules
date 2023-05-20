import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:http/http.dart' as http;
import 'package:skripsi_c14190201/murid/detail_guru.dart';
import 'package:skripsi_c14190201/murid/history_sesi_murid.dart';

class review_guru extends StatefulWidget {
  final Map data_transaksi;
  review_guru({super.key, required this.data_transaksi});

  @override
  State<review_guru> createState() => _review_guruState(data_transaksi);
}

class _review_guruState extends State<review_guru> {
  final Map data_transaksi;
  _review_guruState(this.data_transaksi);

  void initState() {
    print(data_transaksi);
    super.initState();
  }

  void dispose() {
    penilaianmuridController.dispose();
    komentarmuridController.dispose();
    super.dispose();
  }

  TextEditingController penilaianmuridController = TextEditingController();
  TextEditingController komentarmuridController = TextEditingController();

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
        await http.post(Uri.parse("http://10.0.2.2:8000/api/review"), body: {
      "id_sesi": data_transaksi['id_sesi'].toString(),
      "id_murid": data_transaksi['id_murid'].toString(),
      "id_guru": data_transaksi['id_guru'].toString(),
      "penilaian_sesi": penilaianmuridController.text,
      "komentar_sesi": komentarmuridController.text,
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
            "Review",
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
                        controller: penilaianmuridController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Penilaian (0 - 10)",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: komentarmuridController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Komentar",
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
                          save_review();
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

  Future save_review() async {
    if (penilaianmuridController.text.isEmpty ||
        komentarmuridController.text.isEmpty) {
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
            title: "Data Review Berhasil Ditambahkan",
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
            return detail_guru(
              index_user: data_transaksi['id_murid'],
              index_guru: data_transaksi['id_guru'],
            );
          },
        ),
      );
    }
  }
}
