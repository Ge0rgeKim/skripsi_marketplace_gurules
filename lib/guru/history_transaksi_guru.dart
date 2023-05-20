import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/detail_sesi_guru.dart';
import 'package:http/http.dart' as http;
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';

class history_transaksi_guru extends StatefulWidget {
  int? index_user;
  history_transaksi_guru({super.key, required this.index_user});

  @override
  State<history_transaksi_guru> createState() =>
      _history_transaksi_guruState(index_user);
}

class _history_transaksi_guruState extends State<history_transaksi_guru> {
  int? index_user;
  _history_transaksi_guruState(this.index_user);
  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future getdatasesi() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:8000/api/sesi"));
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
            "History Transaksi",
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
          child: FutureBuilder(
            future: getdatasesi(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data['data'].length,
                    itemBuilder: (context, index) {
                      if (snapshot.data['data'][index]['id_guru'] ==
                              index_user &&
                          snapshot.data['data'][index]['status_sesi'] == 1) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "ID Sesi : " +
                                      snapshot.data['data'][index]['id']
                                          .toString(),
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_upward,
                                          color: Colors.green,
                                          size: 15,
                                        ),
                                        Text(
                                          "Harga : " +
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
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_downward,
                                          color: Colors.red,
                                          size: 15,
                                        ),
                                        Text(
                                          "Pajak(10%): " +
                                              NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: "Rp. ",
                                                      decimalDigits: 0)
                                                  .format(
                                                snapshot.data['data'][index]
                                                        ['nominal_saldo'] *
                                                    0.1,
                                              ),
                                          style: TextStyle(
                                            fontFamily: "Roboto",
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Icon(
                                          SkripsiIcon.wallet,
                                          size: 15,
                                        ),
                                        Text(
                                          "Total : " +
                                              NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: "Rp. ",
                                                      decimalDigits: 0)
                                                  .format(
                                                (snapshot.data['data'][index]
                                                        ['nominal_saldo']) -
                                                    (snapshot.data['data']
                                                                [index]
                                                            ['nominal_saldo'] *
                                                        0.1),
                                              ),
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
                            SizedBox(
                              height: 10,
                            )
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
        ),
      ),
    );
  }
}
