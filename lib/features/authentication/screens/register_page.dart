import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/widgets/button.dart';
import '../../../core/theme/font_theme.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/widgets/text_field.dart';
import '../providers/auth_provider.dart';

import 'login_page.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
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
              const SizedBox(height: 16),
              Text(
                "Password Konfirmasi",
                style: FontTheme.blackSubtitle(),
              ),
              const SizedBox(height: 8),
              BookpalsTextField(
                title: "Password Konfirmasi",
                hint: "Masukkan password konfirmasi",
                controller: _passwordConfirmationController,
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
                      text: "Daftar",
                      // isLoading: ,
                      onTap: () async {
                        if (_usernameController.text.isEmpty ||
                            _passwordController.text.isEmpty ||
                            _passwordConfirmationController.text.isEmpty) {
                          setState(() {
                            errorMessage =
                                "Username dan password harus di-isi!";
                          });
                          return;
                        }

                        final response = await auth.signUp(
                          _usernameController.text,
                          _passwordController.text,
                          _passwordConfirmationController.text,
                        );

                        if (response["status"]) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                                SnackBar(content: Text(response['message'])));
                        } else {
                          setState(() {
                            errorMessage = response["message"];
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
                    text: 'Sudah Memiliki Akun? ',
                    style: FontTheme.blackCaption(),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' Masuk Akun',
                        style: FontTheme.blackCaptionBold(),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) => const SignInPage(),
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
