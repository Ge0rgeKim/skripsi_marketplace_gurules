import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/daftar_sesi.dart';
import 'package:http/http.dart' as http;

class tambah_sesi extends StatefulWidget {
  int? index;
  tambah_sesi({super.key, required this.index});

  @override
  State<tambah_sesi> createState() => _tambah_sesiState(index);
}

class _tambah_sesiState extends State<tambah_sesi> {
  int? index;
  _tambah_sesiState(this.index);
  void initState() {
    print(index);
    super.initState();
  }

  void dispose() {
    hargaSesiGuruController.dispose();
    super.dispose();
  }

  TextEditingController hargaSesiGuruController = TextEditingController();

  Future savedata() async {
    String tgl = time.day.toString() +
        "/" +
        time.month.toString() +
        "/" +
        time.year.toString();
    final response =
        await http.post(Uri.parse("http://10.0.2.2:8000/api/sesi"), body: {
      'id_guru': index.toString(),
      'tanggal_sesi': tgl,
      'waktu_sesi': selectedvalue,
      'nominal_saldo': hargaSesiGuruController.text,
    });
  }

  List<dynamic> sesi_guru = [];
  List<String> jam_sesi = [];
  List<String> tgl_sesi = [];
  Future getdatasesi() async {
    var response = await http.get(Uri.parse("http://10.0.2.2:8000/api/sesi"));
    sesi_guru = json.decode(response.body)["data"];
    return json.decode(response.body)["data"];
  }

  void isi_data_sesi() {
    if (jam_sesi.length < sesi_guru.length) {
      sesi_guru.forEach((element) {
        if (element["id_guru"] == index) {
          jam_sesi.add(element["waktu_sesi"] as String);
          tgl_sesi.add(element["tanggal_sesi"] as String);
        }
      });
    }
  }

  bool cek_sesi = false;
  void cekdata() {
    String tgl = time.day.toString() +
        "/" +
        time.month.toString() +
        "/" +
        time.year.toString();
    for (int i = 0; i < jam_sesi.length; i++) {
      if (selectedvalue == jam_sesi[i] && tgl == tgl_sesi[i]) {
        cek_sesi = true;
      }
    }
  }

  @override
  var time = DateTime.now();
  final jam = [
    "00:00 - 01:00",
    "01:00 - 02:00",
    "02:00 - 03:00",
    "03:00 - 04:00",
    "04:00 - 05:00",
    "05:00 - 06:00",
    "06:00 - 07:00",
    "07:00 - 08:00",
    "08:00 - 09:00",
    "09:00 - 10:00",
    "10:00 - 11:00",
    "11:00 - 12:00",
    "12:00 - 13:00",
    "13:00 - 14:00",
    "14:00 - 15:00",
    "15:00 - 16:00",
    "16:00 - 17:00",
    "17:00 - 18:00",
    "18:00 - 19:00",
    "19:00 - 20:00",
    "20:00 - 21:00",
    "21:00 - 22:00",
    "22:00 - 23:00",
    "23:00 - 00:00",
  ];
  String? selectedvalue;
  Widget build(BuildContext context) {
    getdatasesi();
    isi_data_sesi();
    String tgl = time.day.toString() +
        "/" +
        time.month.toString() +
        "/" +
        time.year.toString();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Skripsi c14190201",
      home: Scaffold(
        backgroundColor: containerColor,
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: Text(
            "Tambah Sesi",
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
                  Text(
                    tgl,
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
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
                            "Pilih Jadwal Sesi",
                            style: TextStyle(
                              fontFamily: "Roboto",
                              fontSize: 20,
                            ),
                          ),
                          items: jam.map(buildmenuitem).toList(),
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
                        controller: hargaSesiGuruController,
                        autofocus: true,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text(
                            "Harga Sesi",
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
                          save_sesi();
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

  Future save_sesi() async {
    if (hargaSesiGuruController.text.isEmpty || selectedvalue == null) {
      Alert(
        context: context,
        title: "Data belum lengkap",
        type: AlertType.error,
        buttons: [],
      ).show();
    } else {
      cekdata();
      if (cek_sesi) {
        Alert(
          context: context,
          title: "Jam Sudah ada",
          type: AlertType.error,
          buttons: [],
        ).show();
        cek_sesi = false;
      } else {
        savedata().then((value) {
          Alert(
            context: context,
            title: "Jadwal Sesi Berhasil Ditambahkan",
            type: AlertType.success,
            buttons: [],
          ).show();
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return daftar_sesi(index: index);
            },
          ),
        );
        cek_sesi = false;
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
