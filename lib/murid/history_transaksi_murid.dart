import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:http/http.dart' as http;

class history_transaksi_murid extends StatefulWidget {
  int? index_user;
  history_transaksi_murid({super.key, required this.index_user});

  @override
  State<history_transaksi_murid> createState() =>
      _history_transaksi_muridState(index_user);
}

class _history_transaksi_muridState extends State<history_transaksi_murid> {
  int? index_user;
  _history_transaksi_muridState(this.index_user);
  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  List<dynamic> data_user = [];
  int saldo_user = 0;
  Future getdatasaldo() async {
    var response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/saldo/" + index_user.toString()));
    data_user = json.decode(response.body)["data"];
    if (data_user.isNotEmpty) {
      saldo_user = data_user[data_user.length - 1]["total"];
    }
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
          child: Column(
            children: [
              FutureBuilder(
                future: getdatasaldo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      data_user.isEmpty
                          ? NumberFormat.currency(
                                  locale: 'id',
                                  symbol: "Rp. ",
                                  decimalDigits: 0)
                              .format(saldo_user)
                          : NumberFormat.currency(
                                  locale: 'id',
                                  symbol: "Rp. ",
                                  decimalDigits: 0)
                              .format(saldo_user),
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
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
              FutureBuilder(
                future: getdatasaldo(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, index) {
                          if (snapshot.data['data'][index]['debit'] != 0) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_upward,
                                          color: Colors.green,
                                          size: 25,
                                        ),
                                        Text(
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: "Rp. ",
                                                  decimalDigits: 0)
                                              .format(
                                            snapshot.data['data'][index]
                                                ['debit'],
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
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          } else if (snapshot.data['data'][index]['credit'] !=
                              0) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.arrow_downward,
                                          color: Colors.red,
                                          size: 25,
                                        ),
                                        Text(
                                          NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: "Rp. ",
                                                  decimalDigits: 0)
                                              .format(
                                            snapshot.data['data'][index]
                                                ['credit'],
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
                                SizedBox(
                                  height: 10,
                                )
                              ],
                            );
                          }
                        },
                      ),
                    );
                  } else {
                    return Text("data error");
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
