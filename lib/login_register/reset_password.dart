import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/main.dart';
import 'package:http/http.dart' as http;

class reset_password extends StatefulWidget {
  const reset_password({super.key});

  @override
  State<reset_password> createState() => _reset_passwordState();
}

class _reset_passwordState extends State<reset_password> {
  @override
  void initState() {
    super.initState();
  }

  void dispose() {
    emailResetController.dispose();
    passResetController.dispose();
    confirPassResetController.dispose();
    super.dispose();
  }

  TextEditingController emailResetController = TextEditingController();
  TextEditingController passResetController = TextEditingController();
  TextEditingController confirPassResetController = TextEditingController();
  Future savedatamurid(int? i) async {
    final response = await http.put(
        Uri.parse("http://10.0.2.2:8000/api/user_murid/" + i.toString()),
        body: {
          "email": temp1_murid,
          "username": temp2_murid,
          "password": passResetController.text,
        });
  }

  //nanti bikin save data guru
  List<dynamic> akun_murid = [];
  List<String> email_murid = [];
  List<String> user_murid = [];
  Future getdatamurid() async {
    var response =
        await http.get(Uri.parse("http://10.0.2.2:8000/api/user_murid"));
    akun_murid = json.decode(response.body)["data"];
    return json.decode(response.body)["data"];
  }

  void isi_data_murid() {
    if (email_murid.length < akun_murid.length) {
      akun_murid.forEach((element) {
        email_murid.add(element["email"] as String);
        user_murid.add(element["username"] as String);
      });
    }
  }

  List<dynamic> akun_guru = [];
  List<String> email_guru = [];
  List<String> user_guru = [];
  Future getdataguru() async {
    // var response = await http.get(Uri.parse(""));
    // akun_guru = json.decode(response.body)["data"];
    // return json.decode(response.body)["data"];
  }
  void isi_data_guru() {
    if (email_guru.length < akun_guru.length) {
      akun_guru.forEach((element) {
        email_guru.add(element["email"] as String);
        user_guru.add(element["username"] as String);
      });
    }
  }

  bool cek_guru = false;
  bool cek_murid = false;
  int? index_guru;
  int? index_murid;
  String temp1_murid = "";
  String temp2_murid = "";
  String temp1_guru = "";
  String temp2_guru = "";

  void cekdatamurid() {
    for (int i = 0; i < email_murid.length; i++) {
      if (emailResetController.text == email_murid[i]) {
        cek_murid = true;
        index_murid = i + 1;
        temp1_murid = email_murid[i];
        temp2_murid = user_murid[i];
      }
    }
  }

  void cekdataguru() {
    for (int i = 0; i < email_guru.length; i++) {
      if (emailResetController.text == email_guru[i]) {
        cek_guru = true;
        index_guru = i + 1;
        temp1_guru = email_guru[i];
        temp2_guru = user_guru[i];
      }
    }
  }

  final user = ["Guru", "Murid"];
  String? selectedvalue;
  Widget build(BuildContext context) {
    getdatamurid();
    isi_data_murid();
    getdataguru();
    isi_data_guru();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Skripsi c14190201",
      home: Scaffold(
        backgroundColor: containerColor,
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: Text(
            "Reset Password",
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
                  Column(
                    children: [
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
                            "Pilih User",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                            ),
                          ),
                          items: user.map(buildmenuitem).toList(),
                          value: selectedvalue,
                          onChanged: (value) {
                            setState(() {
                              selectedvalue = value;
                            });
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Email",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                            ),
                          ),
                        ),
                        controller: emailResetController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "New Password",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                            ),
                          ),
                        ),
                        controller: passResetController,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Confirm Password",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                            ),
                          ),
                        ),
                        controller: confirPassResetController,
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
                          user_reset_pass();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: buttoncolor,
                        ),
                        child: Text(
                          "Reset Password",
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
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future user_reset_pass() async {
    if (emailResetController.text.isEmpty ||
        passResetController.text.isEmpty ||
        confirPassResetController.text.isEmpty) {
      Alert(
        context: context,
        title: "Data tidak valid",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else {
      if (passResetController.text != confirPassResetController.text) {
        Alert(
          context: context,
          title: "Data Password tidak valid",
          type: AlertType.error,
          buttons: [],
        ).show();
      } else {
        if ((passResetController.text).length < 8) {
          Alert(
            context: context,
            title: "Password harus lebih dari 8 huruf/karakter",
            type: AlertType.error,
            buttons: [],
          ).show();
        } else {
          if (selectedvalue == "Guru") {
            cekdataguru();
            if (cek_guru) {
              Alert(
                context: context,
                title: "ya",
                type: AlertType.error,
                buttons: [],
              ).show();
            } else {
              Alert(
                context: context,
                title: "Akun guru tidak terdaftar",
                type: AlertType.error,
                buttons: [],
              ).show();
            }
          } else if (selectedvalue == "Murid") {
            cekdatamurid();
            if (cek_murid) {
              savedatamurid(index_murid).then((value) {
                Alert(
                  context: context,
                  title: "Reset Password Akun Berhasil",
                  type: AlertType.success,
                  buttons: [],
                ).show();
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MyApp();
                  },
                ),
              );
            } else {
              Alert(
                context: context,
                title: "Akun murid tidak terdaftar",
                type: AlertType.error,
                buttons: [],
              ).show();
            }
          }
        }
      }
    }
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
