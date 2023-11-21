import 'package:bookpals_mobile/features/authentication/screens/login_page.dart';
import 'package:bookpals_mobile/features/main/screens/home_page.dart';
import 'package:bookpals_mobile/services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'features/authentication/providers/auth_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await APIHelper.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provider<CookieRequest>(create: (context) => CookieRequest()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'BookPals',
        theme: ThemeData(
          fontFamily: 'Poppins',
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: (APIHelper.isSignedIn() ? const HomePage() : const SignInPage()),
      ),
    );
  }
}
