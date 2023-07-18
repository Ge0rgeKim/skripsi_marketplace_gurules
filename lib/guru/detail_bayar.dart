import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:http/http.dart' as http;
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';

class detail_bayar_guru extends StatefulWidget {
  final Map data_bayar;
  detail_bayar_guru({super.key, required this.data_bayar});

  @override
  State<detail_bayar_guru> createState() => _detail_bayar_guruState(data_bayar);
}

class _detail_bayar_guruState extends State<detail_bayar_guru> {
  final Map data_bayar;
  _detail_bayar_guruState(this.data_bayar);

  void initState() {
    print(data_bayar);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future getdatasesi() async {
    var response = await http.get(
      Uri.parse(
        "https://literasimilenial.net/george/public/api/sesi/" +
            data_bayar['id_sesi'].toString(),
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
            "Detail Pembayaran",
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
                  Text(
                    data_bayar['no_transaksi_sesi'],
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 25,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  FutureBuilder(
                    future: getdatasesi(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_upward,
                                  color: Colors.green,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Harga : " +
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: "Rp. ",
                                              decimalDigits: 0)
                                          .format(
                                        int.parse(snapshot.data['data']
                                            ['nominal_saldo']),
                                      ),
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.arrow_downward,
                                  color: Colors.red,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Pajak(10%): " +
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: "Rp. ",
                                              decimalDigits: 0)
                                          .format(
                                        int.parse(snapshot.data['data']
                                                ['nominal_saldo']) *
                                            0.1,
                                      ),
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  SkripsiIcon.wallet,
                                  size: 18,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Total : " +
                                      NumberFormat.currency(
                                              locale: 'id',
                                              symbol: "Rp. ",
                                              decimalDigits: 0)
                                          .format(
                                        (int.parse(
                                              snapshot.data['data']
                                                  ['nominal_saldo'],
                                            )) -
                                            (int.parse(
                                                  snapshot.data['data']
                                                      ['nominal_saldo'],
                                                ) *
                                                0.1),
                                      ),
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 15,
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
                    height: 15,
                  ),
                  Image.network(
                    "https://literasimilenial.net/george/public/" +
                        data_bayar['bukti_pembayaran'],
                    fit: BoxFit.cover,
                    loadingBuilder: (context, child, loadingProgress) {
                      return loadingProgress == null
                          ? child
                          : Text("Loading..");
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
