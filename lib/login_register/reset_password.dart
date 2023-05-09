import 'dart:convert';
import 'dart:ffi';

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
          "email": temp_email_murid,
          "username": temp_user_murid,
          "password": passResetController.text,
        });
  }

  Future savedataguru(int? i) async {
    final response = await http.put(
        Uri.parse("http://10.0.2.2:8000/api/user_guru/" + i.toString()),
        body: {
          //id_admin,mata_pelajaran,ktp,lokasi,status_sesi,status_akun,
          "id_admin": temp_idAdmin_guru,
          "mata_pelajaran": temp_mataPelajaran_guru,
          "ktp": temp_ktp_guru,
          "lokasi": temp_lokasi_guru,
          "status_sesi": temp_statusSesi_guru,
          "status_akun": temp_statusAkun_guru,
          "email": temp_email_guru,
          "username": temp_user_guru,
          "password": passResetController.text,
        });
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
  int? index_guru;
  int? index_murid;

  String? temp_email_murid;
  String? temp_user_murid;

  String? temp_email_guru;
  String? temp_user_guru;
  String? temp_idAdmin_guru;
  String? temp_mataPelajaran_guru;
  String? temp_ktp_guru;
  String? temp_lokasi_guru;
  int? temp_statusSesi_guru;
  int? temp_statusAkun_guru;
  void cekdatamurid() {
    for (int i = 0; i < email_murid.length; i++) {
      if (emailResetController.text == email_murid[i]) {
        cek_murid = true;
        index_murid = akun_murid[i]["id"];
        temp_email_murid = akun_murid[i]["email"];
        temp_user_murid = akun_murid[i]["username"];
      }
    }
  }

  void cekdataguru() {
    for (int i = 0; i < email_guru.length; i++) {
      if (emailResetController.text == email_guru[i]) {
        cek_guru = true;
        index_guru = akun_guru[i]["id"];
        temp_email_guru = akun_guru[i]["email"];
        temp_user_guru = akun_guru[i]["username"];
        temp_statusAkun_guru = akun_guru[i]["status_akun"];
        temp_statusSesi_guru = akun_guru[i]["status_sesi"];
        temp_idAdmin_guru = akun_guru[i]["id_admin"];
        temp_mataPelajaran_guru = akun_guru[i]["mata_pelajaran"];
        temp_ktp_guru = akun_guru[i]["ktp"];
        temp_lokasi_guru = akun_guru[i]["lokasi"];
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
        confirPassResetController.text.isEmpty ||
        selectedvalue == null) {
      Alert(
        context: context,
        title: "Data belum lengkap",
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
              if (temp_statusAkun_guru != 0) {
                savedataguru(index_guru).then((value) {
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
                title: "Akun guru tidak terdaftar",
                type: AlertType.error,
                buttons: [],
              ).show();
            }
            cek_guru = false;
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
              cek_murid = false;
            } else {
              Alert(
                context: context,
                title: "Akun murid tidak terdaftar",
                type: AlertType.error,
                buttons: [],
              ).show();
            }
            cek_murid = false;
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
