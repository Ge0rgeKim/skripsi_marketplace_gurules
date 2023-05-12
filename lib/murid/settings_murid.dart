import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/main.dart';
import 'package:skripsi_c14190201/murid/history_sesi_murid.dart';
import 'package:skripsi_c14190201/murid/history_transaksi_murid.dart';

class settings_murid extends StatefulWidget {
  int? index;
  settings_murid({super.key, required this.index});

  @override
  State<settings_murid> createState() => _settings_muridState(index);
}

class _settings_muridState extends State<settings_murid> {
  int? index;
  _settings_muridState(this.index);
  void initState() {
    print(index);
    super.initState();
  }

  void dispose() {
    super.dispose();
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
            "Settings",
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
              padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return history_sesi_murid();
                          },
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "History Sesi",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 20,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return history_transaksi_murid();
                          },
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "History Transaksi",
                          style: TextStyle(
                            fontFamily: "Roboto",
                            fontSize: 20,
                          ),
                        ),
                        Icon(
                          Icons.arrow_right_outlined,
                          color: Colors.black,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    thickness: 1,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 250,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return MyApp();
                          },
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: buttoncolor,
                    ),
                    child: Text(
                      "Logout",
                      style: TextStyle(
                        fontFamily: "Roboto",
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
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
}
