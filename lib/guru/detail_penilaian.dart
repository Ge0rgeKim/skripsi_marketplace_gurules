import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';

class detail_penilaian extends StatefulWidget {
  int? index_user;
  detail_penilaian({super.key, required this.index_user});

  @override
  State<detail_penilaian> createState() => _detail_penilaianState(index_user);
}

class _detail_penilaianState extends State<detail_penilaian> {
  int? index_user;
  _detail_penilaianState(this.index_user);
  void initState() {
    print(index_user);
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
                        "<ID Sesi>",
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
                        "<Mata Pelajaran>",
                        style: TextStyle(
                          fontFamily: "Roboto",
                          fontSize: 13,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "<Tanggal>",
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
                            "<Waktu Sesi>",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "<ID Murid>",
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
                            "<Nilai>",
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
                    "<Isi Komentar>",
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
