import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/widgets/button.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../authentication/providers/auth_provider.dart';
import '../../authentication/screens/login_page.dart';
import '../../book-swap/providers/swap_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final swapProvider = context.watch<SwapProvider>();

    return BpScaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 60,
              width: 200,
              child: BpButton(
                text: "Logout",
                onTap: () async {
                  // Clear Swap Provider Cache
                  swapProvider.logOut();
                  await auth.logout();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInPage(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
