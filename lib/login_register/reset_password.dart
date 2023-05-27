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

  // Future reset_user() async {
  //   var response = await http.put(
  //       Uri.parse("http://10.0.2.2:8000/api/login_user/reset_user"),
  //       body: {
  //         "email": emailResetController.text,
  //         "password": passResetController.text,
  //         "users": selectedvalue
  //       });
  //   return json.decode(response.body)['message'];
  // }

  Future reset_user() async {
    var response = await http.put(
        Uri.parse(
          "https://literasimilenial.net/george/public/api/login_user/reset_user",
        ),
        body: {
          "email": emailResetController.text,
          "password": passResetController.text,
          "users": selectedvalue
        });
    return json.decode(response.body)['message'];
  }

  final user = ["Guru", "Murid"];
  String? selectedvalue;
  Widget build(BuildContext context) {
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
          reset_user().then((value) {
            if (selectedvalue == "Guru") {
              if (value == "success") {
                Alert(
                  context: context,
                  title: "Password Guru Berhasil Di Ubah",
                  type: AlertType.success,
                  buttons: [],
                ).show();
              } else {
                Alert(
                  context: context,
                  title: value,
                  type: AlertType.error,
                  buttons: [],
                ).show();
              }
            } else if (selectedvalue == "Murid") {
              if (value == "success") {
                Alert(
                  context: context,
                  title: "Password Murid Berhasil Di Ubah",
                  type: AlertType.success,
                  buttons: [],
                ).show();
              } else {
                Alert(
                  context: context,
                  title: value,
                  type: AlertType.error,
                  buttons: [],
                ).show();
              }
            }
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return MyApp();
              },
            ),
          );
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
