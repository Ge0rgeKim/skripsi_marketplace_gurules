import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/bayar_sesi.dart';
import 'package:skripsi_c14190201/murid/detail_sesi_murid.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';

class detail_guru extends StatefulWidget {
  const detail_guru({super.key});

  @override
  State<detail_guru> createState() => _detail_guruState();
}

class _detail_guruState extends State<detail_guru> {
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
            "Detail Guru",
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
        body: Container(
          padding: EdgeInsets.fromLTRB(5, 30, 5, 30),
          child: Column(
            children: [
              Column(
                children: [
                  Text(
                    "<Username Guru>",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "<Mata Pelajaran Guru>",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 13,
                    ),
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
                        "<Status>",
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
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "<Tanggal Sesi>",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return bayar_sesi();
                                },
                              ),
                            );
                          },
                          child: Text(
                            "<Waktu Sesi>",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 15,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return detail_sesi_murid();
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: buttoncolor,
                          ),
                          child: Text(
                            "Detail",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Text(
                          "<Harga>",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Review",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "<Rata-rata Nilai>",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    " | ",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    "<Total Jumlah Review>",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      children: [
                        Icon(
                          SkripsiIcon.user,
                          size: 25,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "<username murid>",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  "<Total Nilai>",
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
                                  "<Review>",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
