import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/detail_sesi_guru.dart';
import 'package:skripsi_c14190201/guru/tambah_sesi.dart';
import 'package:http/http.dart' as http;

class daftar_sesi extends StatefulWidget {
  int? index_user;
  daftar_sesi({super.key, required this.index_user});

  @override
  State<daftar_sesi> createState() => _daftar_sesiState(index_user);
}

class _daftar_sesiState extends State<daftar_sesi> {
  int? index_user;
  _daftar_sesiState(this.index_user);
  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  // Future getdatasesi() async {
  //   var response = await http.get(Uri.parse("http://10.0.2.2:8000/api/sesi"));
  //   return json.decode(response.body);
  // }

  Future getdatasesi() async {
    var response = await http.get(
      Uri.parse("https://literasimilenial.net/george/public/api/sesi"),
    );
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
            "Daftar Sesi",
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
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return tambah_sesi(index_user: index_user);
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: buttoncolor,
                ),
                child: Text(
                  "Tambah Sesi",
                  style: TextStyle(
                    fontFamily: "Roboto",
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
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
                          if (int.parse(snapshot.data['data'][index]['id_guru']) ==
                              index_user) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  snapshot.data['data'][index]['tanggal_sesi'],
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  snapshot.data['data'][index]['waktu_sesi'],
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  NumberFormat.currency(
                                          locale: 'id',
                                          symbol: "Rp. ",
                                          decimalDigits: 0)
                                      .format(
                                    int.parse(snapshot.data['data'][index]
                                        ['nominal_saldo']),
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
                                          return detail_sesi_guru(
                                            index_sesi: snapshot.data['data']
                                                [index]['id'],
                                            index_user: index_user,
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
                        },
                      ),
                    );
                  } else {
                    return Text("data error");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
