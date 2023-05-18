import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/history_transaksi_murid.dart';
import 'package:http/http.dart' as http;

class topup_saldo extends StatefulWidget {
  int? index_user;
  topup_saldo({super.key, required this.index_user});

  @override
  State<topup_saldo> createState() => _topup_saldoState(index_user);
}

class _topup_saldoState extends State<topup_saldo> {
  int? index_user;
  _topup_saldoState(this.index_user);
  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    nominalTopUpController.dispose();
    super.dispose();
  }

  TextEditingController nominalTopUpController = TextEditingController();

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

  Future savedata() async {
    Map<String, String> body = {
      "nominal_saldo": nominalTopUpController.text,
    };
    var response = await add_dataTopUp(body, pickedfile_!.path, index_user);
    if (response) {
      setState(() {
        pickedfile_ = null;
      });
    }
  }

  static Future<bool> add_dataTopUp(
      Map<String, String> body, String filepath, int? n) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Connection': 'Keep-Alive'
    };

    var request = http.MultipartRequest('POST',
        Uri.parse("http://10.0.2.2:8000/api/transaksi_saldo/" + n.toString()))
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
            "Topup Saldo",
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
                        controller: nominalTopUpController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Nominal Saldo",
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
                                "No Image Top Up Selected",
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
                          save_topup();
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

  Future save_topup() async {
    if (nominalTopUpController.text.isEmpty || pickedfile_ == null) {
      Alert(
        context: context,
        title: "Data belum lengkap",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else {
      savedata().then((value) {
        Alert(
          context: context,
          title: "Top Up Berhasil, Mohon Menunggu Konfirmasi",
          type: AlertType.success,
          buttons: [],
        ).show();
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return history_transaksi_murid(index_user: index_user);
          },
        ),
      );
    }
  }
}
