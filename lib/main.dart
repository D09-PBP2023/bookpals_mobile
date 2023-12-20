import 'core/theme/color_theme.dart';
import 'features/authentication/screens/login_page.dart';
import 'features/book-swap/providers/swap_provider.dart';
import 'features/main/screens/home_page.dart';
import 'services/api.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'core/bases/providers/book_provider.dart';
import 'core/bases/providers/profile_provider.dart';
import 'features/authentication/providers/auth_provider.dart';
import 'features/request/providers/bookrequest_provider.dart';
import 'features/request/providers/submitrequest_provider.dart';
import 'core/bases/providers/review_provider.dart';

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
        ChangeNotifierProvider(create: (_) => BookProvider()),
        ChangeNotifierProvider(create: (_) => SwapProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => BookRequestProvider()),
        ChangeNotifierProvider(create: (_) => SubmitBookRequestProvider()),
        ChangeNotifierProvider(create: (_) => ReviewProvider()),
      ],
      child: MaterialApp(
        title: 'BookPals',
        theme: ThemeData(
          canvasColor: Colors.transparent,
          fontFamily: 'PlusJakartaSans',
          colorScheme: ColorScheme.fromSeed(seedColor: ColorTheme.almondDust),
          useMaterial3: true,
        ),
        home: (APIHelper.isSignedIn() ? const HomePage() : const SignInPage()),
      ),
    );
  }
}
