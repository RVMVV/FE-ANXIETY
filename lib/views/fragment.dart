import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../utils/constant_finals.dart';
import 'history.dart';
import 'home.dart';
import 'settings.dart';

class FragmentPage extends StatefulWidget {
  const FragmentPage({super.key});

  @override
  State<FragmentPage> createState() => _FragmentPageState();
}

class _FragmentPageState extends State<FragmentPage> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomePage(),
    const HistoryPage(),
    const SettingsPage(),
  ];

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(icHome),
            label: 'Home',
            activeIcon: SvgPicture.asset(
              icHome,
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(icHistory),
            label: 'History',
            activeIcon: SvgPicture.asset(
              icHistory,
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(icSetting),
            label: 'Settings',
            activeIcon: SvgPicture.asset(
              icSetting,
              colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
            ),
          ),
        ],
        selectedItemColor: primaryColor,
      ),
    );
  }
}
