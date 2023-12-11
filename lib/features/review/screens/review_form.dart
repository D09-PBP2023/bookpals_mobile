import 'package:bookpals_mobile/core/bases/widgets/button.dart';
import 'package:bookpals_mobile/core/theme/font_theme.dart';
import 'package:bookpals_mobile/features/authentication/providers/auth_provider.dart';
import 'package:bookpals_mobile/features/main/screens/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../core/bases/models/Book.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/widgets/text_field.dart';

class ReviewFormPage extends StatefulWidget {
  final Book book; // Accept Book as a parameter

  const ReviewFormPage({Key? key, required this.book}) : super(key: key);

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0;
  bool isLoading = false;
  late String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book.fields.name}'),
      ),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Text(
                "Rating",
                style: FontTheme.blackSubtitle(),
              ),
              const SizedBox(height: 8),
              RatingBar.builder(
                initialRating: _rating,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemSize: 40,
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  _rating = rating;
                },
              ),
              const SizedBox(height: 16),
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
                "Review",
                style: FontTheme.blackSubtitle(),
              ),
              const SizedBox(height: 8),
              BookpalsTextField(
                title: "Review",
                hint: "Enter your review",
                controller: _reviewController,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60,
                    width: 200,
                    child: BpButton(
                      text: "Submit",
                      // isLoading: isLoading,
                      onTap: () async {
                        if (_rating == 0) {
                          setState(() {
                            errorMessage = "Please give a rate";
                          });
                          return;
                        }
                        // if (_usernameController.text.isEmpty ||
                        //     _passwordController.text.isEmpty) {
                        //   setState(() {
                        //     errorMessage =
                        //         "Username dan password harus di-isi!";
                        //   });
                        //   return;
                        // }

                        // setState(() {
                        //   isLoading = true;
                        // });

                        // final res = await auth.signIn(
                        //     _usernameController.text, _passwordController.text);

                        // setState(() {
                        //   isLoading = false;
                        // });

                        // if (res["status"]) {
                        //   Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const HomePage()),
                        //   );
                        // } else {
                        //   setState(() {
                        //     errorMessage = res["message"];
                        //   });
                        // }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}