import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/history_guru.dart';
import 'package:skripsi_c14190201/murid/history_sesi_murid.dart';
import 'package:skripsi_c14190201/murid/jadwal_sesi.dart';
import 'package:skripsi_c14190201/murid/topup_saldo.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';

class home_murid extends StatefulWidget {
  int? index;
  home_murid({super.key, required this.index});

  @override
  State<home_murid> createState() => _home_muridState(index);
}

class _home_muridState extends State<home_murid> {
  int? index;
  _home_muridState(this.index);
  void initState() {
    print(index);
    super.initState();
  }

  void dispose() {
    super.dispose();
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
                            Text(
                              "<Total Saldo>",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 20,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return history_guru(index: index);
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
                                      return jadwal_sesi(index: index);
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
                                      return history_sesi_murid(index: index);
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
                                      return topup_saldo(index: index);
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
