import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class sesi_guru extends StatefulWidget {
  final Map data_guru;
  sesi_guru({super.key, required this.data_guru});

  @override
  State<sesi_guru> createState() => _sesi_guruState(data_guru);
}

class _sesi_guruState extends State<sesi_guru> {
  final Map data_guru;
  _sesi_guruState(this.data_guru);
  void initState() {
    print(data_guru);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  Future getdataguru() async {
    var response = await http.get(Uri.parse(
        "http://10.0.2.2:8000/api/user_guru/" +
            data_guru['id_guru'].toString()));
    return json.decode(response.body);
  }
  
  final status = ["Online Onsite", "Online", "Onsite"];
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
            "Detail Sesi",
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
              child: FutureBuilder(
                future: getdataguru(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text(
                          snapshot.data['data']['username'],
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          snapshot.data['data']['mata_pelajaran'],
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 13,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              snapshot.data['data']['lokasi'],
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              " | ",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 13,
                              ),
                            ),
                            Text(
                              status[snapshot.data['data']['status_sesi']],
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 100,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            final Uri whatsapp_user = Uri.parse('https://wa.me/+6281354958833');
                            launchUrl(whatsapp_user);
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
                        )
                      ],
                    );
                  } else {
                    return Text("data error");
                  }
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
