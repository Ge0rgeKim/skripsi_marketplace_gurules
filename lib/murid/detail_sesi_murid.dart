import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';

class detail_sesi_murid extends StatefulWidget {
  const detail_sesi_murid({super.key});

  @override
  State<detail_sesi_murid> createState() => _detail_sesi_muridState();
}

class _detail_sesi_muridState extends State<detail_sesi_murid> {
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
                      Text(
                        "<Harga Sesi>",
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
                        "<ID Guru>",
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
                            "<Lokasi>",
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
                            "<Status Sesi>",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 13,
                            ),
                          ),
                        ],
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
}
