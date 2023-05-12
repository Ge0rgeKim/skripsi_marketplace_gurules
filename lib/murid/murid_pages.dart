import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/murid/home_murid.dart';
import 'package:skripsi_c14190201/murid/profile_murid.dart';
import 'package:skripsi_c14190201/murid/settings_murid.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';

class murid_pages extends StatefulWidget {
  int? index;
  murid_pages({super.key, required this.index});

  @override
  State<murid_pages> createState() => _murid_pagesState(index);
}

class _murid_pagesState extends State<murid_pages> {
  int? index;
  _murid_pagesState(this.index);
  void initState() {
    print(index);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  List pages = [
    profile_murid(),
    home_murid(),
    settings_murid(),
  ];
  int page_index = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[page_index],
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        backgroundColor: containerColor,
        currentIndex: page_index,
        onTap: (index) => setState(
          () => page_index = index,
        ),
        selectedItemColor: buttoncolor,
        unselectedItemColor: buttoncolor.withOpacity(0.5),
        selectedFontSize: 20,
        unselectedFontSize: 17,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                SkripsiIcon.user_1,
                size: 20,
              ),
              label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(
                SkripsiIcon.home,
                size: 20,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(
                SkripsiIcon.cog_outline,
                size: 20,
              ),
              label: "Settings"),
        ],
      ),
    );
  }
}
