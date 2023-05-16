import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/guru_pages.dart';
import 'package:skripsi_c14190201/login_register/reset_password.dart';
import 'package:skripsi_c14190201/login_register/role_register.dart';
import 'package:skripsi_c14190201/murid/murid_pages.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  TextEditingController emaillogincontroller = TextEditingController();
  TextEditingController passlogincontroller = TextEditingController();

  void initState() {
    super.initState();
  }

  void dispose() {
    emaillogincontroller.dispose();
    passlogincontroller.dispose();
    super.dispose();
  }

  List<dynamic> akun_murid = [];
  List<String> email_murid = [];
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
      });
    }
  }

  List<dynamic> akun_guru = [];
  List<String> email_guru = [];
  Future getdataguru() async {
    var response =
        await http.get(Uri.parse("http://10.0.2.2:8000/api/user_guru"));
    akun_guru = json.decode(response.body)["data"];
    return json.decode(response.body)["data"];
  }

  void isi_data_guru() {
    if (email_guru.length < akun_guru.length) {
      akun_guru.forEach((element) {
        email_guru.add(element["email"] as String);
      });
    }
  }

  bool cek_guru = false;
  bool cek_murid = false;
  int? id_murid;
  int? id_guru;
  String? pass_murid;
  String? pass_guru;
  int? status_guru;
  void cekdata() {
    for (int i = 0; i < email_murid.length; i++) {
      if (emaillogincontroller.text == email_murid[i]) {
        cek_murid = true;
        id_murid = akun_murid[i]["id"];
        pass_murid = akun_murid[i]["password"];
      }
    }
    for (int i = 0; i < email_guru.length; i++) {
      if (emaillogincontroller.text == email_guru[i]) {
        cek_guru = true;
        id_guru = akun_guru[i]["id"];
        pass_guru = akun_guru[i]["password"];
        status_guru = akun_guru[i]["status_akun"];
      }
    }
  }

  final user = ["Guru", "Murid"];
  String? selectedvalue;
  @override
  Widget build(BuildContext context) {
    getdatamurid();
    getdataguru();
    isi_data_murid();
    isi_data_guru();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Skripsi c14190201",
      home: Scaffold(
        backgroundColor: containerColor,
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: Text(
            "Login",
            style: TextStyle(
              fontFamily: "Roboto",
              fontSize: 25,
              fontWeight: FontWeight.bold,
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
                  Column(
                    children: [
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
                        controller: emaillogincontroller,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Password",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                            ),
                          ),
                        ),
                        controller: passlogincontroller,
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
                          userlogin();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: buttoncolor,
                        ),
                        child: Text(
                          "Login",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return role_register();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Register Account Here",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return reset_password();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Reset Password Account Here",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontSize: 15,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future userlogin() async {
    cekdata();
    if (emaillogincontroller.text.isEmpty ||
        passlogincontroller.text.isEmpty ||
        selectedvalue == null) {
      Alert(
        context: context,
        title: "Data belum lengkap",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else {
      if (selectedvalue == "Guru") {
        if (cek_guru) {
          if (passlogincontroller.text == pass_guru) {
            if (status_guru == 1) {
              print(id_guru);
              Alert(
                context: context,
                title: "Guru Berhasil Login",
                type: AlertType.success,
                buttons: [],
              ).show();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return guru_pages(index: id_guru);
                  },
                ),
              );
              cek_guru = false;
            } else {
              Alert(
                context: context,
                title: "Akun belum divalidasi oleh admin",
                type: AlertType.error,
                buttons: [],
              ).show();
            }
          } else {
            Alert(
              context: context,
              title: "Password Akun Guru Salah",
              type: AlertType.error,
              buttons: [],
            ).show();
          }
        } else {
          Alert(
            context: context,
            title: "Akun Guru Belum Terdaftar",
            type: AlertType.error,
            buttons: [],
          ).show();
        }
        cek_guru = false;
      } else if (selectedvalue == "Murid") {
        if (cek_murid) {
          if (passlogincontroller.text == pass_murid) {
            print(id_murid);
            Alert(
              context: context,
              title: "Murid Berhasil Login",
              type: AlertType.success,
              buttons: [],
            ).show();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return murid_pages(index: id_murid);
                },
              ),
            );
            cek_murid = false;
          } else {
            Alert(
              context: context,
              title: "Password Akun Murid Salah",
              type: AlertType.error,
              buttons: [],
            ).show();
          }
        } else {
          Alert(
            context: context,
            title: "Akun Murid Belum Terdaftar",
            type: AlertType.error,
            buttons: [],
          ).show();
        }
        cek_murid = false;
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
