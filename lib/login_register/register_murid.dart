import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/main.dart';

class register_murid extends StatefulWidget {
  const register_murid({super.key});

  @override
  State<register_murid> createState() => _register_muridState();
}

class _register_muridState extends State<register_murid> {
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
            "Register Murid",
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
                        autofocus: true,
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
                      TextField(
                        autofocus: true,
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
                        autofocus: true,
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
                  SizedBox(
                    height: 5,
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
