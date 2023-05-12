import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/main.dart';
import 'package:http/http.dart' as http;

class register_guru extends StatefulWidget {
  const register_guru({super.key});

  @override
  State<register_guru> createState() => _register_guruState();
}

class _register_guruState extends State<register_guru> {
  void initState() {
    super.initState();
  }

  void dispose() {
    userGuruRegistController.dispose();
    emailGuruRegistController.dispose();
    lokasiGuruRegistController.dispose();
    passGuruRegistController.dispose();
    confirpassGuruRegistController.dispose();
    super.dispose();
  }

  TextEditingController userGuruRegistController = TextEditingController();
  TextEditingController emailGuruRegistController = TextEditingController();
  TextEditingController lokasiGuruRegistController = TextEditingController();
  TextEditingController passGuruRegistController = TextEditingController();
  TextEditingController confirpassGuruRegistController =
      TextEditingController();

  File? image_;
  var pickedfile_;
  final picker_ = ImagePicker();
  Future<void> pickimage_() async {
    pickedfile_ = await picker_.getImage(source: ImageSource.gallery);
    if (pickedfile_ != null) {
      setState(() {
        image_ = File(pickedfile_!.path);
      });
    }
  }

  List<dynamic> data = [];
  List<String> data_value = [];
  final String url = "http://10.0.2.2:8000/api/mata_pelajaran";
  String? selectedvalue;
  Future getdata() async {
    var response = await http.get(Uri.parse(url));
    data = json.decode(response.body)["data"];
    return json.decode(response.body)["data"];
  }

  void isi_data() {
    if (data_value.length < data.length) {
      data.forEach((element) {
        data_value.add(element["mata_pelajaran"] as String);
      });
    }
  }

  Future savedata() async {
    Map<String, String> body = {
      "username": userGuruRegistController.text,
      "email": emailGuruRegistController.text,
      "password": passGuruRegistController.text,
      "mata_pelajaran": selectedvalue.toString(),
      "lokasi": lokasiGuruRegistController.text,
    };
    var response = await add_dataRegist(body, pickedfile_!.path);
    if (response) {
      setState(() {
        pickedfile_ = null;
      });
    }
  }

  static Future<bool> add_dataRegist(
      Map<String, String> body, String filepath) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Connection': 'Keep-Alive'
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse("http://10.0.2.2:8000/api/user_guru"))
      ..fields.addAll(body)
      ..headers.addAll(headers)
      ..files.add(await http.MultipartFile.fromPath('image', filepath));

    var response = await request.send();
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
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
  void cekdata() {
    for (int i = 0; i < email_guru.length; i++) {
      if (emailGuruRegistController.text == email_guru[i]) {
        cek_guru = true;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getdata();
    isi_data();
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
            "Register Guru",
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
                        controller: userGuruRegistController,
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
                        controller: emailGuruRegistController,
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
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: lokasiGuruRegistController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Lokasi (Kota)",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                            ),
                          ),
                          hintText:
                              "(Surabaya, Jakarta) Data jangan di singkat",
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextField(
                        controller: passGuruRegistController,
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
                        controller: confirpassGuruRegistController,
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
                      SizedBox(
                        height: 15,
                      ),
                      IconButton(
                        onPressed: () {
                          pickimage_();
                        },
                        icon: Icon(
                          Icons.upload,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: pickedfile_ == null
                            ? Text(
                                "No Image Selected",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 15,
                                ),
                              )
                            : Image.file(File(pickedfile_!.path)),
                      )
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
                          guru_regist();
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

  Future guru_regist() async {
    if (userGuruRegistController.text.isEmpty ||
        emailGuruRegistController.text.isEmpty ||
        lokasiGuruRegistController.text.isEmpty ||
        passGuruRegistController.text.isEmpty ||
        confirpassGuruRegistController.text.isEmpty ||
        selectedvalue.toString().isEmpty ||
        pickedfile_ == null) {
      Alert(
        context: context,
        title: "Data belum lengkap",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else {
      if (passGuruRegistController.text !=
          confirpassGuruRegistController.text) {
        Alert(
          context: context,
          title: "Data Password tidak valid",
          type: AlertType.error,
          buttons: [],
        ).show();
      } else {
        if ((passGuruRegistController.text).length < 8) {
          Alert(
            context: context,
            title: "Password harus lebih dari 8 huruf/karakter",
            type: AlertType.error,
            buttons: [],
          ).show();
        } else {
          cekdata();
          if (cek_guru) {
            Alert(
              context: context,
              title: "Email User sudah terdaftar/terpakai",
              type: AlertType.error,
              buttons: [],
            ).show();
            cek_guru = false;
          } else {
            savedata().then((value) {
              Alert(
                context: context,
                title: "Registrasi Akun Berhasil",
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
          }
          cek_guru = false;
        }
      }
    }
  }
}
