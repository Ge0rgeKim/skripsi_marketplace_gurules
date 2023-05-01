import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/detail_guru.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';

class jadwal_sesi extends StatefulWidget {
  const jadwal_sesi({super.key});

  @override
  State<jadwal_sesi> createState() => _jadwal_sesiState();
}

class _jadwal_sesiState extends State<jadwal_sesi> {
  @override
  final list1 = ["1", "2", "3"];
  final list2 = ["4", "5", "6"];
  final list3 = ["7", "8", "9"];
  String? selectedvalue1;
  String? selectedvalue2;
  String? selectedvalue3;
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Skripsi c14190201",
      home: Scaffold(
        backgroundColor: containerColor,
        appBar: AppBar(
          backgroundColor: appbarColor,
          title: Text(
            "Jadwal Sesi",
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
        body: Container(
          padding: EdgeInsets.fromLTRB(5, 30, 5, 30),
          child: Column(
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
                    "Pilih Mata Pelajaran Guru",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20,
                    ),
                  ),
                  items: list1.map(buildmenuitem).toList(),
                  value: selectedvalue1,
                  onChanged: (value) {
                    setState(() {
                      selectedvalue1 = value;
                    });
                  },
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
                    "Pilih Jadwal Sesi",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20,
                    ),
                  ),
                  items: list2.map(buildmenuitem).toList(),
                  value: selectedvalue2,
                  onChanged: (value) {
                    setState(() {
                      selectedvalue2 = value;
                    });
                  },
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
                    "Pilih Lokasi Guru",
                    style: TextStyle(
                      fontFamily: "Roboto",
                      fontSize: 20,
                    ),
                  ),
                  items: list3.map(buildmenuitem).toList(),
                  value: selectedvalue3,
                  onChanged: (value) {
                    setState(() {
                      selectedvalue3 = value;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              SkripsiIcon.user,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "<username guru>",
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
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
                                      "<Status>",
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "<Mata Pelajaran>",
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
                                      "<Lokasi>",
                                      style: TextStyle(
                                        fontFamily: "Roboto",
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return detail_guru();
                                },
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            primary: buttoncolor,
                          ),
                          child: Text(
                            "Detail",
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
            ],
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
}
