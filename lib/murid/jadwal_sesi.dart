import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/detail_guru.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';
import 'package:http/http.dart' as http;

class jadwal_sesi extends StatefulWidget {
  int? index_user;
  jadwal_sesi({super.key, required this.index_user});

  @override
  State<jadwal_sesi> createState() => _jadwal_sesiState(index_user);
}

class _jadwal_sesiState extends State<jadwal_sesi> {
  int? index_user;
  _jadwal_sesiState(this.index_user);
  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  @override
  // Future getdataguru() async {
  //   var response =
  //       await http.get(Uri.parse("http://10.0.2.2:8000/api/user_guru"));
  //   return json.decode(response.body);
  // }

  Future getdataguru() async {
    var response = await http.get(
      Uri.parse("https://literasimilenial.net/george/public/api/user_guru"),
    );
    return json.decode(response.body);
  }

  List<dynamic> data = [];
  List<String> data_value = [];
  // final String url = "http://10.0.2.2:8000/api/mata_pelajaran";
  final String url =
      "https://literasimilenial.net/george/public/api/mata_pelajaran";
  String? selectedvalue;
  String? selectedvalue1;
  Future getdata() async {
    var response = await http.get(Uri.parse(url));
    data = json.decode(response.body)["data"];
    isi_data();
    return json.decode(response.body)["data"];
  }

  void isi_data() {
    if (data_value.length < data.length) {
      data.forEach((element) {
        data_value.add(element["mata_pelajaran"] as String);
      });
    }
  }

  List<dynamic> data1 = [];
  List<String> data_value1 = [];
  final String url1 = "https://literasimilenial.net/george/public/api/kota";
  String? selectedvalue2;
  Future getdatakota() async {
    var response = await http.get(Uri.parse(url1));
    data1 = json.decode(response.body)["data"];
    isi_datakota();
    return json.decode(response.body)["data"];
  }

  void isi_datakota() {
    if (data_value1.length < data1.length) {
      data1.forEach((element) {
        data_value1.add(element["kota"] as String);
      });
    }
  }

  final status = ["Online Onsite", "Online", "Onsite"];
  Widget build(BuildContext context) {
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
              FutureBuilder(
                future: getdata(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black)),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        hint: Text(
                          "Mata Pelajaran",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 20,
                          ),
                        ),
                        items: data_value.map(buildmenuitem).toList(),
                        value: selectedvalue,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue = value;
                          });
                        },
                      ),
                    );
                  } else {
                    return Text("data error");
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black)),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  hint: Text(
                    "Status Sesi",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20,
                    ),
                  ),
                  items: status.map(buildmenuitem).toList(),
                  value: selectedvalue1,
                  onChanged: (value) {
                    setState(() {
                      selectedvalue1 = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 15,
              ),
              FutureBuilder(
                future: getdatakota(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black)),
                      child: DropdownButton<String>(
                        isExpanded: true,
                        underline: SizedBox(),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        hint: Text(
                          "Lokasi (Kota)",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 20,
                          ),
                        ),
                        items: data_value1.map(buildmenuitem).toList(),
                        value: selectedvalue2,
                        onChanged: (value) {
                          setState(() {
                            selectedvalue2 = value;
                          });
                        },
                      ),
                    );
                  } else {
                    return Text("data error");
                  }
                },
              ),
              SizedBox(
                height: 15,
              ),
              FutureBuilder(
                future: getdataguru(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data['data'].length,
                        itemBuilder: (context, index) {
                          if (snapshot.data['data'][index]['status_akun'] ==
                              '1') {
                            if (selectedvalue == null &&
                                selectedvalue1 == null &&
                                selectedvalue2 == null) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                status[int.parse(
                                                    snapshot.data['data'][index]
                                                        ['status_sesi'])],
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
                                            return detail_guru(
                                              index_user: index_user,
                                              index_guru: snapshot.data['data']
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
                            }
                            if (selectedvalue ==
                                    snapshot.data['data'][index]
                                        ['mata_pelajaran'] &&
                                selectedvalue1 == null &&
                                selectedvalue2 == null) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                status[int.parse(
                                                    snapshot.data['data'][index]
                                                        ['status_sesi'])],
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
                                            return detail_guru(
                                              index_user: index_user,
                                              index_guru: snapshot.data['data']
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
                            }
                            if (selectedvalue == null &&
                                selectedvalue1 ==
                                    status[int.parse(snapshot.data['data']
                                        [index]['status_sesi'])] &&
                                selectedvalue2 == null) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                status[int.parse(
                                                    snapshot.data['data'][index]
                                                        ['status_sesi'])],
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
                                            return detail_guru(
                                              index_user: index_user,
                                              index_guru: snapshot.data['data']
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
                            }
                            if (selectedvalue == null &&
                                selectedvalue1 == null &&
                                selectedvalue2 ==
                                    snapshot.data['data'][index]['lokasi']) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                status[int.parse(
                                                    snapshot.data['data'][index]
                                                        ['status_sesi'])],
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
                                            return detail_guru(
                                              index_user: index_user,
                                              index_guru: snapshot.data['data']
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
                            }
                            if (selectedvalue ==
                                    snapshot.data['data'][index]
                                        ['mata_pelajaran'] &&
                                selectedvalue1 ==
                                    status[int.parse(snapshot.data['data']
                                        [index]['status_sesi'])] &&
                                selectedvalue2 == null) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                status[int.parse(
                                                    snapshot.data['data'][index]
                                                        ['status_sesi'])],
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
                                            return detail_guru(
                                              index_user: index_user,
                                              index_guru: snapshot.data['data']
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
                            }
                            if (selectedvalue ==
                                    snapshot.data['data'][index]
                                        ['mata_pelajaran'] &&
                                selectedvalue1 == null &&
                                selectedvalue2 ==
                                    snapshot.data['data'][index]['lokasi']) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                status[int.parse(
                                                    snapshot.data['data'][index]
                                                        ['status_sesi'])],
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
                                            return detail_guru(
                                              index_user: index_user,
                                              index_guru: snapshot.data['data']
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
                            }
                            if (selectedvalue == null &&
                                selectedvalue1 ==
                                    status[int.parse(snapshot.data['data']
                                        [index]['status_sesi'])] &&
                                selectedvalue2 ==
                                    snapshot.data['data'][index]['lokasi']) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                status[int.parse(
                                                    snapshot.data['data'][index]
                                                        ['status_sesi'])],
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
                                            return detail_guru(
                                              index_user: index_user,
                                              index_guru: snapshot.data['data']
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
                            }
                            if (selectedvalue ==
                                    snapshot.data['data'][index]
                                        ['mata_pelajaran'] &&
                                selectedvalue1 ==
                                    status[int.parse(snapshot.data['data']
                                        [index]['status_sesi'])] &&
                                selectedvalue2 ==
                                    snapshot.data['data'][index]['lokasi']) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
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
                                                status[int.parse(
                                                    snapshot.data['data'][index]
                                                        ['status_sesi'])],
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
                                            return detail_guru(
                                              index_user: index_user,
                                              index_guru: snapshot.data['data']
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

  DropdownMenuItem<String> buildmenuitem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
            fontFamily: "Roboto",
            fontSize: 20,
          ),
        ),
      );
}
