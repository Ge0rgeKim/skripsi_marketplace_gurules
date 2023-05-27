import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/profile_guru.dart';
import 'package:http/http.dart' as http;

class edit_profile_guru extends StatefulWidget {
  final Map data_profile;
  edit_profile_guru({super.key, required this.data_profile});

  @override
  State<edit_profile_guru> createState() =>
      _edit_profile_guruState(data_profile);
}

class _edit_profile_guruState extends State<edit_profile_guru> {
  final Map data_profile;
  _edit_profile_guruState(this.data_profile);
  void initState() {
    super.initState();
  }

  void dispose() {
    dataUserGuruController.dispose();
    dataPassGuruController.dispose();
    dataLokasiGuruController.dispose();
    super.dispose();
  }

  TextEditingController dataUserGuruController = TextEditingController();
  TextEditingController dataPassGuruController = TextEditingController();
  TextEditingController dataLokasiGuruController = TextEditingController();

  Future updatedataguru() async {
    int? n;
    for (int i = 0; i < 3; i++) {
      if (selectedvalue == status[i]) {
        n = i;
      }
    }
    // var response = await http.put(
    //     Uri.parse("http://10.0.2.2:8000/api/user_guru/" +
    //         data_profile["id"].toString()),
    //     body: {
    //       'username': dataUserGuruController.text,
    //       'email': data_profile['email'],
    //       'password': dataPassGuruController.text,
    //       'mata_pelajaran': data_profile['mata_pelajaran'],
    //       'lokasi': dataLokasiGuruController.text,
    //       'status_sesi': n.toString(),
    //     });

    var response = await http.put(
      Uri.parse(
        "https://literasimilenial.net/george/public/api/user_guru/" +
            data_profile["id"].toString(),
      ),
      body: {
        'username': dataUserGuruController.text,
        'email': data_profile['email'],
        'password': dataPassGuruController.text,
        'mata_pelajaran': data_profile['mata_pelajaran'],
        'lokasi': dataLokasiGuruController.text,
        'status_sesi': n.toString(),
      },
    );
    return json.decode(response.body);
  }

  final status = ["Online Onsite", "Online", "Onsite"];
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
                        controller: dataUserGuruController
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
                        controller: dataPassGuruController
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
                      TextField(
                        controller: dataLokasiGuruController
                          ..text = data_profile['lokasi'],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Lokasi (Kota, Jangan di singkat)",
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
                            "Pilih Status Sesi",
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
                          guru_profile_update();
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

  Future guru_profile_update() async {
    if (dataUserGuruController.text.isEmpty ||
        dataPassGuruController.text.isEmpty ||
        dataLokasiGuruController.text.isEmpty ||
        selectedvalue == null) {
      Alert(
        context: context,
        title: "Data belum lengkap",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else if ((dataPassGuruController.text).length < 8) {
      Alert(
        context: context,
        title: "Password harus lebih dari 8 huruf/karakter",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else {
      updatedataguru().then((value) {
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
            return profile_guru(index_user: data_profile["id"]);
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
