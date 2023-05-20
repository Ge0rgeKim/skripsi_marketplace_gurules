import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/detail_sesi_guru.dart';
import 'package:http/http.dart' as http;

class history_sesi_guru extends StatefulWidget {
  int? index_user;
  history_sesi_guru({super.key, required this.index_user});

  @override
  State<history_sesi_guru> createState() => _history_sesi_guruState(index_user);
}

class _history_sesi_guruState extends State<history_sesi_guru> {
  int? index_user;
  _history_sesi_guruState(this.index_user);
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
            "History Sesi",
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
                    return Text(
                      "Total Sesi : " +
                          (snapshot.data['data'].length).toString(),
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 20,
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
                                        //nnti return id sesi
                                        return detail_sesi_guru(
                                          index_user: index_user,
                                          index_sesi: snapshot.data['data'][index]['id_sesi'],
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
