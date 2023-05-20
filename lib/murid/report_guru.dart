import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/history_sesi_murid.dart';
import 'package:http/http.dart' as http;

class report_guru extends StatefulWidget {
  int? index_user;
  int? index_sesi;
  report_guru({super.key, required this.index_user, required this.index_sesi});

  @override
  State<report_guru> createState() => _report_guruState(index_user, index_sesi);
}

class _report_guruState extends State<report_guru> {
  int? index_user;
  int? index_sesi;
  _report_guruState(this.index_user, this.index_sesi);

  void initState() {
    print(index_user);
    print(index_sesi);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  String mataPelajaran = "";
  Future getdatasesi() async {
    var response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/sesi/" + index_sesi.toString()));
    var response2 = await http.get(Uri.parse(
        "http://10.0.2.2:8000/api/user_guru/" +
            json.decode(response.body)['data']['id_guru'].toString()));
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
                child: FutureBuilder(
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
                                "ID Guru : " +
                                    snapshot.data['data']['id_guru'].toString(),
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
                              TextField(
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
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return history_sesi_murid(
                                            index_user: index_user);
                                      },
                                    ),
                                  );
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
                      );
                    } else {
                      return Text("data error");
                    }
                  },
                )),
          ),
        ),
      ),
    );
  }
}
