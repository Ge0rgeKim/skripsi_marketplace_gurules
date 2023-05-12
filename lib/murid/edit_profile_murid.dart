import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/profile_murid.dart';
import 'package:http/http.dart' as http;

class edit_profile_murid extends StatefulWidget {
  final Map data_profile;
  edit_profile_murid({super.key, required this.data_profile});

  @override
  State<edit_profile_murid> createState() =>
      _edit_profile_muridState(this.data_profile);
}

class _edit_profile_muridState extends State<edit_profile_murid> {
  final Map data_profile;
  _edit_profile_muridState(this.data_profile);
  void initState() {
    super.initState();
  }

  void dispose() {
    dataUserMuridControlller.dispose();
    dataPassMuridControlller.dispose();
    super.dispose();
  }

  TextEditingController dataUserMuridControlller = TextEditingController();
  TextEditingController dataPassMuridControlller = TextEditingController();

  Future updatedatamurid() async {
    var response = await http.put(
        Uri.parse("http://10.0.2.2:8000/api/user_murid/" +
            data_profile["id"].toString()),
        body: {
          "username": dataUserMuridControlller.text,
          "email": data_profile["email"],
          "password": dataPassMuridControlller.text
        });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    print(data_profile);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Skripsi c14190201",
      home: Scaffold(
        backgroundColor: containerColor,
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: Text(
            "Edit Profile",
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
                        controller: dataUserMuridControlller
                          ..text = data_profile["username"],
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
                        controller: dataPassMuridControlller
                          ..text = data_profile["password"],
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
                          murid_profile_update();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: buttoncolor,
                        ),
                        child: Text(
                          "Submit",
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

  Future murid_profile_update() async {
    if (dataUserMuridControlller.text.isEmpty ||
        dataPassMuridControlller.text.isEmpty) {
      Alert(
        context: context,
        title: "Data belum lengkap",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else if ((dataPassMuridControlller.text).length < 8) {
      Alert(
        context: context,
        title: "Password harus lebih dari 8 huruf/karakter",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else {
      updatedatamurid().then((value) {
        Alert(
          context: context,
          title: "Data Berhasil di Update",
          type: AlertType.success,
          buttons: [],
        ).show();
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return profile_murid(index: data_profile["id"]);
          },
        ),
      );
    }
  }
}
