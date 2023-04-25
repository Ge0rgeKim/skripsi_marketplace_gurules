import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/login_register/register_guru.dart';
import 'package:skripsi_c14190201/login_register/register_murid.dart';

class role_register extends StatefulWidget {
  const role_register({super.key});

  @override
  State<role_register> createState() => _role_registerState();
}

class _role_registerState extends State<role_register> {
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
            "Register",
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
                  Row(
                    children: [
                      Expanded(
                        child: Builder(builder: (context) {
                          return ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return register_murid();
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: buttoncolor,
                            ),
                            child: Text(
                              "Register as User Murid",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Builder(builder: (context) {
                          return ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return register_guru();
                                  },
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: buttoncolor,
                            ),
                            child: Text(
                              "Register as User Guru",
                              style: TextStyle(
                                fontFamily: "Roboto",
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          );
                        }),
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
