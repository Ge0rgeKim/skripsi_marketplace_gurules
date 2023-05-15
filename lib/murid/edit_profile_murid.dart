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
      _edit_profile_muridState(data_profile);
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
    if (selectedvalue == null) {
      selectedvalue = "tidak";
    }
    var response = await http.put(
        Uri.parse("http://10.0.2.2:8000/api/user_murid/" +
            data_profile["id"].toString()),
        body: {
          "username": dataUserMuridControlller.text,
          "email": data_profile["email"],
          "password": dataPassMuridControlller.text,
          "status_reward": selectedvalue,
        });
    return json.decode(response.body);
  }

  final status = ["ya", "tidak"];
  String? selectedvalue;

  @override
  Widget build(BuildContext context) {
    if (data_profile['status_reward'] != 1) {
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
                              "Mau Ambil Saldo Bonus?",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 20,
                              ),
                            ),
                            items: status.map(buildmenuitem).toList(),
                            value: selectedvalue,
                            onChanged: (value) {
                              setState(() {
                                selectedvalue = value;
                              });
                            },
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
    } else {
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
