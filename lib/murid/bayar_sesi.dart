import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/history_guru.dart';
import 'package:http/http.dart' as http;

class bayar_sesi extends StatefulWidget {
  int? index_user;
  int? index_sesi;
  bayar_sesi({super.key, required this.index_user, required this.index_sesi});

  @override
  State<bayar_sesi> createState() => _bayar_sesiState(index_user, index_sesi);
}

class _bayar_sesiState extends State<bayar_sesi> {
  int? index_user;
  int? index_sesi;
  _bayar_sesiState(this.index_user, this.index_sesi);

  void initState() {
    print(index_user);
    print(index_sesi);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  String mataPelajaran = "";
  int harga_sesi = 0;
  Future getdatasesi() async {
    var response = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/sesi/" + index_sesi.toString()));
    var response2 = await http.get(Uri.parse(
        "http://10.0.2.2:8000/api/user_guru/" +
            json.decode(response.body)['data']['id_guru'].toString()));
    mataPelajaran =
        json.decode(response2.body)['data']['mata_pelajaran'].toString();
    harga_sesi = json.decode(response.body)['data']['nominal_saldo'];
    return json.decode(response.body);
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
    return json.decode(response.body)["data"];
  }

  Future savedata() async {
    var response_guru = await http.get(
        Uri.parse("http://10.0.2.2:8000/api/sesi/" + index_sesi.toString()));
    int id_guru = json.decode(response_guru.body)['data']['id_guru'];
    final response = await http.post(
        Uri.parse(
            "http://10.0.2.2:8000/api/transaksi_sesi/" + index_sesi.toString()),
        body: {
          "id_murid": index_user.toString(),
          "id_guru" : id_guru.toString()
        });
    if (response.statusCode == 200) {
      return json.decode(response.body)['message'];
    } else {
      return false;
    }
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
            "Bayar Sesi",
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
                child: FutureBuilder(
                  future: getdatasesi(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
                          Column(
                            children: [
                              Text(
                                "ID Sesi : " +
                                    snapshot.data['data']['id'].toString(),
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
                                mataPelajaran,
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 13,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    snapshot.data['data']['tanggal_sesi'],
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
                                    snapshot.data['data']['waktu_sesi'],
                                    style: TextStyle(
                                      fontFamily: "Roboto",
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                "ID Guru : " +
                                    snapshot.data['data']['id_guru'].toString(),
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
                              FutureBuilder(
                                future: getdatasaldo(),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return Text(
                                      data_user.isEmpty
                                          ? NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: "Saldo User : Rp. ",
                                                  decimalDigits: 0)
                                              .format(saldo_user)
                                          : NumberFormat.currency(
                                                  locale: 'id',
                                                  symbol: "Saldo User : Rp. ",
                                                  decimalDigits: 0)
                                              .format(saldo_user),
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 15,
                                      ),
                                    );
                                  } else {
                                    return Text("data error");
                                  }
                                },
                              ),
                              Text(
                                NumberFormat.currency(
                                        locale: 'id',
                                        symbol: "Harga Sesi : Rp. ",
                                        decimalDigits: 0)
                                    .format(
                                  snapshot.data['data']['nominal_saldo'],
                                ),
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  save_transaksi_sesi();
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: buttoncolor,
                                ),
                                child: Text(
                                  "Bayar",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                  ),
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
                )),
          ),
        ),
      ),
    );
  }

  Future save_transaksi_sesi() async{
    if (saldo_user < harga_sesi) {
      Alert(
        context: context,
        title: "Saldo Tidak Cukup",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else {
      savedata().then((value) {
        Alert(
          context: context,
          title: "Transaksi Sesi Berhasil",
          type: AlertType.success,
          buttons: [],
        ).show();
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return history_guru(index_user: index_user);
          },
        ),
      );
    }
  }
}
