import 'package:flutter/material.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/theme/color_theme.dart';
import '../../book_details/screens/bookmark_page.dart';
import '../../profile/screens/profile_page.dart';
import 'catalog_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final pages = [
    const CatalogPage(),
    const BookmarkPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BpScaffold(
      body: const [
        CatalogPage(), // index 0
        BookmarkPage(),
        ProfilePage(),
      ][_selectedIndex],
      navigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 5),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: NavigationBar(
            destinations: const [
              NavigationDestination(
                icon: Icon(
                  Icons.home,
                  color: Colors.black,
                  weight: 100,
                ),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark),
                label: 'Bookmark',
              ),
              NavigationDestination(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
            selectedIndex: _selectedIndex,
            indicatorColor: ColorTheme.morningDew,
            backgroundColor: ColorTheme.almondDust,
            onDestinationSelected: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
      // navigationBar: BottomAppBar(
      //   height: 150,
      //   padding: const EdgeInsets.all(0),
      //   clipBehavior: Clip.antiAlias,
      //   color: Colors.transparent,
      //   elevation: 0,
      //   child: ClipPath(
      //     clipper: BottomHomeShapeClipper(),
      //     child: Container(
      //       color: ColorTheme.primarySwatch,
      //       alignment: Alignment.bottomCenter,
      //       padding: const EdgeInsets.symmetric(vertical: 8.0),
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.end,
      //         crossAxisAlignment: CrossAxisAlignment.end,
      //         children: [
      //           Expanded(
      //             child: GestureDetector(
      //               child: const Column(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [
      //                   Icon(Icons.home, color: ColorTheme.white),
      //                   Text("Home", style: TextStyle(color: ColorTheme.white)),
      //                 ],
      //               ),
      //               onTap: () => setState(() {
      //                 _selectedIndex = 0;
      //               }),
      //             ),
      //           ),
      //           Expanded(
      //             child: GestureDetector(
      //               child: Container(
      //                 height: 50,
      //                 child: const Column(
      //                   crossAxisAlignment: CrossAxisAlignment.center,
      //                   mainAxisAlignment: MainAxisAlignment.end,
      //                   children: [
      //                     Icon(Icons.bookmark, color: ColorTheme.white),
      //                     Text("Home",
      //                         style: TextStyle(color: ColorTheme.white)),
      //                   ],
      //                 ),
      //               ),
      //               onTap: () => setState(() {
      //                 _selectedIndex = 1;
      //               }),
      //             ),
      //           ),
      //           Expanded(
      //             child: GestureDetector(
      //               child: const Column(
      //                 crossAxisAlignment: CrossAxisAlignment.center,
      //                 mainAxisAlignment: MainAxisAlignment.end,
      //                 children: [
      //                   Icon(Icons.person, color: ColorTheme.white),
      //                   Text("Profile",
      //                       style: TextStyle(color: ColorTheme.white)),
      //                 ],
      //               ),
      //               onTap: () => setState(
      //                 () {
      //                   _selectedIndex = 2;
      //                 },
      //               ),
      //             ),
      //           )
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}
