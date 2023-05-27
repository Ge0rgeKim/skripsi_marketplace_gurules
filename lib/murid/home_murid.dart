import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/history_guru.dart';
import 'package:skripsi_c14190201/murid/history_sesi_murid.dart';
import 'package:skripsi_c14190201/murid/jadwal_sesi.dart';
import 'package:skripsi_c14190201/murid/topup_saldo.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';
import 'package:http/http.dart' as http;

class home_murid extends StatefulWidget {
  int? index_user;
  home_murid({super.key, required this.index_user});

  @override
  State<home_murid> createState() => _home_muridState(index_user);
}

class _home_muridState extends State<home_murid> {
  int? index_user;
  _home_muridState(this.index_user);
  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  List<dynamic> data_user = [];
  int saldo_user = 0;
  // Future getdatasaldo() async {
  //   var response = await http.get(
  //       Uri.parse("http://10.0.2.2:8000/api/saldo/" + index_user.toString()));
  //   data_user = json.decode(response.body)["data"];
  //   if (data_user.isNotEmpty) {
  //     saldo_user = data_user[data_user.length - 1]["total"];
  //   }
  //   return json.decode(response.body)["data"];
  // }

  Future getdatasaldo() async {
    var response = await http.get(
      Uri.parse(
        "https://literasimilenial.net/george/public/api/saldo/" +
            index_user.toString(),
      ),
    );
    data_user = json.decode(response.body)["data"];
    if (data_user.isNotEmpty) {
      saldo_user = int.parse(data_user[data_user.length - 1]["total"]);
    }
    return json.decode(response.body)["data"];
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
            "Home",
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
                  Container(
                    color: appbarColor,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FutureBuilder(
                              future: getdatasaldo(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Text(
                                    data_user.isEmpty
                                        ? NumberFormat.currency(
                                                locale: 'id',
                                                symbol: "Rp. ",
                                                decimalDigits: 0)
                                            .format(saldo_user)
                                        : NumberFormat.currency(
                                                locale: 'id',
                                                symbol: "Rp. ",
                                                decimalDigits: 0)
                                            .format(saldo_user),
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  );
                                } else {
                                  return Text("data error");
                                }
                              },
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return history_guru(
                                          index_user: index_user);
                                    },
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                primary: buttoncolor,
                              ),
                              child: Text(
                                "History Guru",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return jadwal_sesi(
                                          index_user: index_user);
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    SkripsiIcon.chalkboard_teacher,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Jadwal Sesi",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
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
                              child: Column(
                                children: [
                                  Icon(
                                    SkripsiIcon.business_time,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "History Sesi",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return topup_saldo(
                                          index_user: index_user);
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    SkripsiIcon.wallet,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Top-Up Saldo",
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
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
