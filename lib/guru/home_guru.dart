import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/daftar_dokumentasi.dart';
import 'package:skripsi_c14190201/guru/daftar_penilaian.dart';
import 'package:skripsi_c14190201/guru/daftar_sesi.dart';
import 'package:skripsi_c14190201/guru/history_murid.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';

class home_guru extends StatefulWidget {
  const home_guru({super.key});

  @override
  State<home_guru> createState() => _home_guruState();
}

class _home_guruState extends State<home_guru> {
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
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return history_murid();
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: buttoncolor,
                          ),
                          child: Text(
                            "History Murid",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
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
                                      return daftar_sesi();
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    SkripsiIcon.book_reader,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Daftar Sesi",
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
                                      return daftar_penilaian();
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    SkripsiIcon.pencil_squared,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Review",
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
                                      return daftar_dokumentasi();
                                    },
                                  ),
                                );
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    SkripsiIcon.doc_add,
                                    size: 20,
                                    color: Colors.grey,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Dokumentasi",
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
