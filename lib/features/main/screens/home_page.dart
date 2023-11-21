import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/widgets/button.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/theme/color_theme.dart';
import '../../authentication/providers/auth_provider.dart';
import '../../authentication/screens/login_page.dart';
import 'widgets/top_home_shape.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return BpScaffold(
      usePadding: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 300,
              child: Stack(
                children: [
                  ClipPath(
                    clipper: TopHomeShapeClipper(),
                    child: Container(
                      color: ColorTheme.primarySwatch,
                    ),
                  ),
                  Positioned(
                    top: 100,
                    width: MediaQuery.of(context).size.width,
                    child: const Center(
                      child: Text(
                        "Halo, Anon!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 60,
              width: 200,
              child: BpButton(
                text: "Logout",
                onTap: () async {
                  await auth.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
