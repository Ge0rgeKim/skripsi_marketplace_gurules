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
  void initState() {
    super.initState();
  }

  void dispose() {
    emaillogincontroller.dispose();
    passlogincontroller.dispose();
    super.dispose();
  }

  TextEditingController emaillogincontroller = TextEditingController();
  TextEditingController passlogincontroller = TextEditingController();

  // Future login_user() async {
  //   var response = await http
  //       .post(Uri.parse("http://10.0.2.2:8000/api/login_user/login"), body: {
  //     "email": emaillogincontroller.text,
  //     "password": passlogincontroller.text,
  //     "users": selectedvalue
  //   });
  //   return json.decode(response.body);
  // }

  Future login_user() async {
    var response = await http
        .post(Uri.parse("https://literasimilenial.net/george/public/api/login_user/login"), body: {
      "email": emaillogincontroller.text,
      "password": passlogincontroller.text,
      "users": selectedvalue
    });
    return json.decode(response.body);
  }

  final user = ["Guru", "Murid"];
  String? selectedvalue;
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
      login_user().then((value) {
        if (selectedvalue == "Guru") {
          if (value['message'] == "success") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return guru_pages(index_user: value['data']);
                },
              ),
            );
          } else {
            Alert(
              context: context,
              title: value['message'],
              type: AlertType.error,
              buttons: [],
            ).show();
          }
        } else if (selectedvalue == "Murid") {
          if (value['message'] == "success") {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return murid_pages(index_user: value['data']);
                },
              ),
            );
          } else {
            Alert(
              context: context,
              title: value['message'],
              type: AlertType.error,
              buttons: [],
            ).show();
          }
        }
      });
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
