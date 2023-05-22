import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/form_dokumentasi.dart';
import 'package:http/http.dart' as http;

class daftar_dokumentasi extends StatefulWidget {
  int? index_user;
  daftar_dokumentasi({super.key, required this.index_user});

  @override
  State<daftar_dokumentasi> createState() =>
      _daftar_dokumentasiState(index_user);
}

class _daftar_dokumentasiState extends State<daftar_dokumentasi> {
  int? index_user;
  _daftar_dokumentasiState(this.index_user);
  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future getdatatransesi() async {
    var response = await http.get(Uri.parse(
        "http://10.0.2.2:8000/api/transaksi_sesi/guru/" +
            index_user.toString()));
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
            "Daftar Dokumentasi",
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
                future: getdatatransesi(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Text(
                                    snapshot.data['data'][index]
                                        ['id_transaksi'],
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
                                        "ID Sesi :" +
                                            snapshot.data['data'][index]
                                                    ['id_sesi']
                                                .toString(),
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
                                        "ID Murid :" +
                                            snapshot.data['data'][index]
                                                    ['id_murid']
                                                .toString(),
                                        style: TextStyle(
                                          fontFamily: "Roboto",
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return form_dokumentasi(
                                          data_sesi: snapshot.data['data']
                                              [index],
                                        );
                                      },
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: buttoncolor,
                                ),
                                child: Text(
                                  "Upload",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          );
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
