import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/bayar_sesi.dart';
import 'package:skripsi_c14190201/murid/detail_sesi_murid.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';
import 'package:http/http.dart' as http;

class detail_guru extends StatefulWidget {
  int? index_user;
  int? index_guru;
  detail_guru({super.key, required this.index_user, required this.index_guru});

  @override
  State<detail_guru> createState() => _detail_guruState(index_user, index_guru);
}

class _detail_guruState extends State<detail_guru> {
  int? index_user;
  int? index_guru;
  _detail_guruState(this.index_user, this.index_guru);

  void initState() {
    print(index_user);
    print(index_guru);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future getdatasesi() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:8000/api/sesi"));
    return json.decode(response.body);
  }

  Future getdataguru() async {
    var response = await http.get(Uri.parse(
        "http://10.0.2.2:8000/api/user_guru/" + index_guru.toString()));
    return json.decode(response.body);
  }

  final status = ["Online Onsite", "Online", "Onsite"];
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
              FutureBuilder(
                future: getdataguru(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text(
                          snapshot.data['data']['username'],
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          snapshot.data['data']['mata_pelajaran'],
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
                              snapshot.data['data']['lokasi'],
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
                              status[snapshot.data['data']['status_sesi']],
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 13,
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
              ),
              SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: getdatasesi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, index) {
                          if (snapshot.data['data'][index]['id_guru'] ==
                              index_guru) {
                            if (snapshot.data['data'][index]['status_sesi'] ==
                                0) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    snapshot.data['data'][index]
                                        ['tanggal_sesi'],
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
                                            return bayar_sesi(
                                              index_user: index_user,
                                              index_sesi: snapshot.data['data']
                                                  [index]['id'],
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    child: Text(
                                      snapshot.data['data'][index]
                                          ['waktu_sesi'],
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    NumberFormat.currency(
                                            locale: 'id',
                                            symbol: "Rp. ",
                                            decimalDigits: 0)
                                        .format(
                                      snapshot.data['data'][index]
                                          ['nominal_saldo'],
                                    ),
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 13,
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return detail_sesi_murid(
                                              index_user: index_user,
                                              index_sesi: snapshot.data['data']
                                                  [index]['id'],
                                            );
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
                            } else {
                              return Container();
                            }
                          } else {
                            return Container();
                          }
                        },
                      ),
                    );
                  } else {
                    return Text("data error");
                  }
                },
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
