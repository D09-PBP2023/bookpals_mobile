import '../../../core/bases/widgets/button.dart';
import '../../../core/theme/font_theme.dart';
import '../providers/auth_provider.dart';
import '../../main/screens/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/widgets/text_field.dart';
import 'register_page.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isLoading = false;
  late String errorMessage = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return BpScaffold(
      resizeToAvoidBottomInset: true,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Center(
              //   child: Image.asset(
              // Assets.ristekLogo,
              //     height: 140,
              //   ),
              // ),
              const SizedBox(height: 30),
              errorMessage.isNotEmpty
                  ? Center(
                      heightFactor: 2,
                      child: Text(
                        errorMessage,
                        style: FontTheme.redSubtitle(),
                      ),
                    )
                  : const Offstage(),
              Text(
                "Username",
                style: FontTheme.blackSubtitle(),
              ),
              const SizedBox(height: 8),
              BookpalsTextField(
                  title: "Username",
                  hint: "Masukkan username",
                  controller: _usernameController),
              const SizedBox(height: 16),
              Text(
                "Password",
                style: FontTheme.blackSubtitle(),
              ),
              const SizedBox(height: 8),
              BookpalsTextField(
                title: "Password",
                hint: "Masukkan password",
                controller: _passwordController,
                isObscure: true,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 200,
                    child: BpButton(
                      text: "Masuk",
                      isLoading: isLoading,
                      onTap: () async {
                        if (_usernameController.text.isEmpty ||
                            _passwordController.text.isEmpty) {
                          setState(() {
                            errorMessage =
                                "Username dan password harus di-isi!";
                          });
                          return;
                        }

                        setState(() {
                          isLoading = true;
                        });

                        final res = await auth.signIn(
                            _usernameController.text, _passwordController.text);

                        setState(() {
                          isLoading = false;
                        });

                        if (res["status"]) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        } else {
                          setState(() {
                            errorMessage = res["message"];
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Belum Memiliki Akun? ',
                    style: FontTheme.blackCaption(),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Buat Akun',
                        style: FontTheme.blackCaptionBold(),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const SignUpPage(),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
