import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/detail_guru.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';
import 'package:http/http.dart' as http;

class jadwal_sesi extends StatefulWidget {
  int? index;
  jadwal_sesi({super.key, required this.index});

  @override
  State<jadwal_sesi> createState() => _jadwal_sesiState(index);
}

class _jadwal_sesiState extends State<jadwal_sesi> {
  int? index;
  _jadwal_sesiState(this.index);
  void initState() {
    super.initState();
  }

  void dispose() {
    mataPelajaranGuru.dispose();
    lokasiGuru.dispose();
    super.dispose();
  }

  TextEditingController mataPelajaranGuru = TextEditingController();
  TextEditingController lokasiGuru = TextEditingController();
  @override
  Future getdataguru() async {
    var response =
        await http.get(Uri.parse("http://10.0.2.2:8000/api/user_guru"));
    return json.decode(response.body);
  }

  final status = ["Online Onsite", "Online", "Onsite"];

  Widget build(BuildContext context) {
    getdataguru();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Skripsi c14190201",
      home: Scaffold(
        backgroundColor: containerColor,
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: Text(
            "Jadwal Sesi",
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
              TextField(
                controller: mataPelajaranGuru,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  label: Text(
                    "Mata Pelajaran Guru",
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
                controller: lokasiGuru,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(),
                  label: Text(
                    "Lokasi Guru",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Expanded(
              //   child: ListView.builder(
              //     itemCount: akun_guru.length,
              //     itemBuilder: (context, index) {
              //       final guru = akun_guru[index];
              //       return Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Row(
              //             children: [
              //               Icon(
              //                 SkripsiIcon.user,
              //                 size: 25,
              //               ),
              //               SizedBox(
              //                 width: 10,
              //               ),
              //               Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   Row(
              //                     children: [
              //                       Text(
              //                         guru.username,
              //                         style: TextStyle(
              //                           fontFamily: "Roboto",
              //                           fontSize: 15,
              //                           fontWeight: FontWeight.bold,
              //                         ),
              //                       ),
              //                       Text(
              //                         " | ",
              //                         style: TextStyle(
              //                           fontFamily: "Roboto",
              //                           fontSize: 13,
              //                         ),
              //                       ),
              //                       Text(
              //                         status[guru.status_akun],
              //                         style: TextStyle(
              //                           fontFamily: "Roboto",
              //                           fontSize: 13,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                   SizedBox(
              //                     height: 5,
              //                   ),
              //                   Row(
              //                     children: [
              //                       Text(
              //                         guru.mata_pelajaran,
              //                         style: TextStyle(
              //                           fontFamily: "Roboto",
              //                           fontSize: 13,
              //                         ),
              //                       ),
              //                       Text(
              //                         " | ",
              //                         style: TextStyle(
              //                           fontFamily: "Roboto",
              //                           fontSize: 13,
              //                         ),
              //                       ),
              //                       Text(
              //                         guru.lokasi,
              //                         style: TextStyle(
              //                           fontFamily: "Roboto",
              //                           fontSize: 13,
              //                         ),
              //                       ),
              //                     ],
              //                   ),
              //                 ],
              //               )
              //             ],
              //           ),
              //           ElevatedButton(
              //             onPressed: () {
              //               Navigator.push(
              //                 context,
              //                 MaterialPageRoute(
              //                   builder: (context) {
              //                     return detail_guru();
              //                   },
              //                 ),
              //               );
              //             },
              //             style: ElevatedButton.styleFrom(
              //               primary: buttoncolor,
              //             ),
              //             child: Text(
              //               "Detail",
              //               style: TextStyle(
              //                 fontFamily: "Roboto",
              //                 fontWeight: FontWeight.bold,
              //                 fontSize: 15,
              //               ),
              //             ),
              //           ),
              //         ],
              //       );
              //     },
              //   ),
              // ),

              FutureBuilder(
                future: getdataguru(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, index) {
                          if (snapshot.data['data'][index]['status_akun'] ==
                              1) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              snapshot.data['data'][index]
                                                  ['username'],
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
                                                fontSize: 13,
                                              ),
                                            ),
                                            Text(
                                              status[snapshot.data['data']
                                                  [index]['status_sesi']],
                                              style: TextStyle(
                                                fontFamily: "Roboto",
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              snapshot.data['data'][index]
                                                  ['mata_pelajaran'],
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
                                              snapshot.data['data'][index]
                                                  ['lokasi'],
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
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return detail_guru();
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
                              ],
                            );
                          }
                        },
                      ),
                    );
                  } else {
                    return Text("Data Error");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void search_matapelajaran(String n) {}

  void search_lokasi(String n) {}
}
