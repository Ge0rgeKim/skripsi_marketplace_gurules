import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/daftar_dokumentasi.dart';
import 'package:http/http.dart' as http;

class form_dokumentasi extends StatefulWidget {
  final Map data_sesi;
  form_dokumentasi({super.key, required this.data_sesi});

  @override
  State<form_dokumentasi> createState() => _form_dokumentasiState(data_sesi);
}

class _form_dokumentasiState extends State<form_dokumentasi> {
  final Map data_sesi;
  _form_dokumentasiState(this.data_sesi);
  void initState() {
    print(data_sesi);
    super.initState();
  }

  void dispose() {
    keteranganDokumentasiController.dispose();
    super.dispose();
  }

  TextEditingController keteranganDokumentasiController =
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

  // String mataPelajaran = "";
  // Future getdatasesi() async {
  //   var response = await http.get(Uri.parse(
  //       "http://10.0.2.2:8000/api/sesi/" + data_sesi['id_sesi'].toString()));
  //   var response2 = await http.get(Uri.parse(
  //       "http://10.0.2.2:8000/api/user_guru/" +
  //           data_sesi['id_guru'].toString()));
  //   mataPelajaran =
  //       json.decode(response2.body)['data']['mata_pelajaran'].toString();
  //   return json.decode(response.body);
  // }

  Future savedata() async {
    Map<String, String> body = {
      'id_sesi': data_sesi['id_sesi'].toString(),
      'id_guru': data_sesi['id_guru'].toString(),
      'keterangan': keteranganDokumentasiController.text
    };
    var response =
        await add_dataTopUp(body, pickedfile_!.path, data_sesi['id_guru']);
    if (response) {
      setState(() {
        pickedfile_ = null;
      });
      return true;
    }
  }

  static Future<bool> add_dataTopUp(
      Map<String, String> body, String filepath, int? n) async {
    Map<String, String> headers = {
      'Content-Type': 'multipart/form-data',
      'Connection': 'Keep-Alive'
    };

    var request = http.MultipartRequest(
        'POST', Uri.parse("http://10.0.2.2:8000/api/dokumentasi/"))
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
            "Upload Dokumentasi",
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
                  // FutureBuilder(
                  //   future: getdatasesi(),
                  //   builder: (context, snapshot) {
                  //     if (snapshot.hasData) {
                  //       return Column(
                  //         children: [
                  //           Text(
                  //             "ID Sesi : " +
                  //                 snapshot.data['data']['id'].toString(),
                  //             style: TextStyle(
                  //               fontFamily: "Roboto",
                  //               fontSize: 15,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: 5,
                  //           ),
                  //           Text(
                  //             mataPelajaran,
                  //             style: TextStyle(
                  //               fontFamily: "Roboto",
                  //               fontSize: 13,
                  //             ),
                  //           ),
                  //           Row(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               Text(
                  //                 snapshot.data['data']['tanggal_sesi'],
                  //                 style: TextStyle(
                  //                   fontFamily: "Roboto",
                  //                   fontSize: 13,
                  //                 ),
                  //               ),
                  //               Text(
                  //                 " | ",
                  //                 style: TextStyle(
                  //                   fontFamily: "Roboto",
                  //                   fontSize: 13,
                  //                 ),
                  //               ),
                  //               Text(
                  //                 snapshot.data['data']['waktu_sesi'],
                  //                 style: TextStyle(
                  //                   fontFamily: "Roboto",
                  //                   fontSize: 13,
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //           Text(
                  //             "ID Guru : " +
                  //                 snapshot.data['data']['id_guru'].toString(),
                  //             style: TextStyle(
                  //               fontFamily: "Roboto",
                  //               fontSize: 13,
                  //             ),
                  //           ),
                  //         ],
                  //       );
                  //     } else {
                  //       return Text("data error");
                  //     }
                  //   },
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      TextField(
                        controller: keteranganDokumentasiController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Keterangan",
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
                                "No Image Dokumentasi Selected",
                                style: TextStyle(
                                  fontFamily: "Roboto",
                                  fontSize: 15,
                                ),
                              )
                            : Image.file(
                                File(pickedfile_!.path),
                              ),
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
                          save_dokumentasi();
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

  Future save_dokumentasi() async {
    if (keteranganDokumentasiController.text.isEmpty || pickedfile_ == null) {
      Alert(
        context: context,
        title: "Data belum lengkap",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else {
      savedata().then((value) {
        print(value);
        if (value == true) {
          Alert(
            context: context,
            title: "Dokumentasi Berhasil Di Upload Ke Sistem",
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
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return daftar_dokumentasi(index_user: data_sesi['id_guru']);
          },
        ),
      );
    }
  }
}
