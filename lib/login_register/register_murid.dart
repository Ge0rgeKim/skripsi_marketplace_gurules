import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/main.dart';
import 'package:http/http.dart' as http;

class register_murid extends StatefulWidget {
  const register_murid({super.key});

  @override
  State<register_murid> createState() => _register_muridState();
}

class _register_muridState extends State<register_murid> {
  @override
  void initState() {
    // getdatamurid();
    // isi_data_murid();
    super.initState();
  }

  void dispose() {
    userMuridRegistController.dispose();
    emailMuridRegistController.dispose();
    passMuridRegistController.dispose();
    confirpassMuridRegistController.dispose();
    super.dispose();
  }

  TextEditingController userMuridRegistController = TextEditingController();
  TextEditingController emailMuridRegistController = TextEditingController();
  TextEditingController passMuridRegistController = TextEditingController();
  TextEditingController confirpassMuridRegistController =
      TextEditingController();

  Future savedata() async {
    final response = await http
        .post(Uri.parse("http://10.0.2.2:8000/api/user_murid"), body: {
      "username": userMuridRegistController.text,
      "email": emailMuridRegistController.text,
      "password": passMuridRegistController.text
    });
  }

  // List<dynamic> akun_murid = [];
  // List<String> email_murid = [];
  // Future getdatamurid() async {
  //   var response =
  //       await http.get(Uri.parse("http://10.0.2.2:8000/api/user_murid"));
  //   akun_murid = json.decode(response.body)["data"];
  //   return json.decode(response.body)["data"];
  // }

  // void isi_data_murid() {
  //   if (email_murid.length < akun_murid.length) {
  //     akun_murid.forEach((element) {
  //       email_murid.add(element["email"] as String);
  //     });
  //   }
  // }

  // bool cek_murid = false;
  // void cekdata() {
  //   for (int i = 0; i < email_murid.length; i++) {
  //     if (emailMuridRegistController.text == email_murid[i]) {
  //       cek_murid = true;
  //     }
  //   }
  // }

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
            "Register Murid",
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
                      TextField(
                        controller: userMuridRegistController,
                        autofocus: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Username",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: emailMuridRegistController,
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
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: passMuridRegistController,
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
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: confirpassMuridRegistController,
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
                          murid_regist();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: buttoncolor,
                        ),
                        child: Text(
                          "Register",
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
                            return MyApp();
                          },
                        ),
                      );
                    },
                    child: Text(
                      "Already Have an Account? Login Here",
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

  Future murid_regist() async {
  //   if (userMuridRegistController.text.isEmpty ||
  //       emailMuridRegistController.text.isEmpty ||
  //       passMuridRegistController.text.isEmpty ||
  //       confirpassMuridRegistController.text.isEmpty) {
  //     Alert(
  //       context: context,
  //       title: "Data belum lengkap",
  //       type: AlertType.error,
  //       buttons: [],
  //     ).show();
  //   } else {
  //     if (passMuridRegistController.text !=
  //         confirpassMuridRegistController.text) {
  //       Alert(
  //         context: context,
  //         title: "Data Password tidak valid",
  //         type: AlertType.error,
  //         buttons: [],
  //       ).show();
  //     } else {
  //       if ((passMuridRegistController.text).length < 8) {
  //         Alert(
  //           context: context,
  //           title: "Password harus lebih dari 8 huruf/karakter",
  //           type: AlertType.error,
  //           buttons: [],
  //         ).show();
  //       } else {
  //         cekdata();
  //         if (cek_murid) {
  //           Alert(
  //             context: context,
  //             title: "Email User sudah terdaftar/terpakai",
  //             type: AlertType.error,
  //             buttons: [],
  //           ).show();
  //           cek_murid = false;
  //         } else {
  //           savedata().then((value) {
  //             Alert(
  //               context: context,
  //               title: "Registrasi Akun Berhasil",
  //               type: AlertType.success,
  //               buttons: [],
  //             ).show();
  //           });
  //           userMuridRegistController.text = "";
  //           emailMuridRegistController.text = "";
  //           passMuridRegistController.text = "";
  //           confirpassMuridRegistController.text = "";
  //         }
  //         cek_murid = false;
  //       }
  //     }
  //   }
  }
}
