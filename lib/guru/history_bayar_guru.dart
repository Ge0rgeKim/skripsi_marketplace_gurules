import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/utils.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/detail_bayar.dart';

class history_bayar_guru extends StatefulWidget {
  int? index_user;
  history_bayar_guru({super.key, required this.index_user});

  @override
  State<history_bayar_guru> createState() =>
      _history_bayar_guruState(index_user);
}

class _history_bayar_guruState extends State<history_bayar_guru> {
  int? index_user;
  _history_bayar_guruState(this.index_user);

  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future getdatabayar() async {
    var response = await http.get(
      Uri.parse(
        "https://literasimilenial.net/george/public/api/bayar_guru/" +
            index_user.toString(),
      ),
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
            "History Pembayaran",
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
                future: getdatabayar(),
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
                                        ['no_transaksi_sesi'],
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "ID Transaksi : " +
                                            snapshot.data['data'][index]
                                                    ['id_transaksi_sesi']
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
                                        "ID Sesi : " +
                                            snapshot.data['data'][index]
                                                    ['id_sesi']
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
                                        return detail_bayar_guru(
                                            data_bayar: snapshot.data['data']
                                                [index]);
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
