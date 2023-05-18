import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:skripsi_c14190201/colors.dart';
import 'package:skripsi_c14190201/guru/home_guru.dart';
import 'package:skripsi_c14190201/guru/profile_guru.dart';
import 'package:skripsi_c14190201/guru/settings_guru.dart';
import 'package:skripsi_c14190201/skripsi_icon_icons.dart';

class guru_pages extends StatefulWidget {
  int? index_user;
  guru_pages({super.key, required this.index_user});

  @override
  State<guru_pages> createState() => _guru_pagesState(index_user);
}

class _guru_pagesState extends State<guru_pages> {
  int? index_user;
  _guru_pagesState(this.index_user);
  void initState() {
    print(index_user);
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  int page_index = 1;
  @override
  Widget build(BuildContext context) {
    List pages = [
      profile_guru(index_user: index_user),
      home_guru(index_user: index_user),
      settings_guru(index_user: index_user)
    ];
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
