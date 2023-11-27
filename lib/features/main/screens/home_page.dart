import 'package:flutter/material.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/theme/color_theme.dart';
import '../../profile/screens/profile_page.dart';
import 'catalog_page.dart';
import 'widgets/home_shape_clipper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final pages = [
    const CatalogPage(),
    const CatalogPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return BpScaffold(
      usePadding: false,
      body: pages[_selectedIndex],
      navigationBar: BottomAppBar(
        height: 150,
        padding: const EdgeInsets.all(0),
        clipBehavior: Clip.antiAlias,
        color: Colors.transparent,
        elevation: 0,
        child: ClipPath(
          clipper: BottomHomeShapeClipper(),
          child: Container(
            color: ColorTheme.primarySwatch,
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: GestureDetector(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.home, color: ColorTheme.white),
                        Text("Home", style: TextStyle(color: ColorTheme.white)),
                      ],
                    ),
                    onTap: () => setState(() {
                      _selectedIndex = 0;
                    }),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      height: 50,
                      child: const Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.bookmark, color: ColorTheme.white),
                          Text("Home",
                              style: TextStyle(color: ColorTheme.white)),
                        ],
                      ),
                    ),
                    onTap: () => setState(() {
                      _selectedIndex = 1;
                    }),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.person, color: ColorTheme.white),
                        Text("Profile",
                            style: TextStyle(color: ColorTheme.white)),
                      ],
                    ),
                    onTap: () => setState(
                      () {
                        _selectedIndex = 2;
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
