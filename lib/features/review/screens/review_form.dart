import 'package:bookpals_mobile/core/bases/widgets/button.dart';
import 'package:bookpals_mobile/core/theme/font_theme.dart';
import 'package:bookpals_mobile/features/authentication/providers/auth_provider.dart';
import 'package:bookpals_mobile/features/main/screens/home_page.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/widgets/text_field.dart';

class ReviewFormPage extends StatefulWidget {
  const ReviewFormPage({super.key});

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  // final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();
  // bool isLoading = false;
  // late String errorMessage = "";
  final _formKey = GlobalKey<FormState>();
  double _rating = 0;

  @override
  Widget build(BuildContext context) {
    // final auth = context.watch<AuthProvider>();

    return BpScaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 30),
                // errorMessage.isNotEmpty
                //     ? Center(
                //         heightFactor: 2,
                //         child: Text(
                //           errorMessage,
                //           style: FontTheme.redSubtitle(),
                //         ),
                //       )
                //     : const Offstage(),
                Text(
                  "Rating",
                  style: FontTheme.blackSubtitle(),
                ),
                const SizedBox(height: 8),
                // Replace the username TextField with a RatingBar
                // You can use any RatingBar package you prefer
                // Here, I'm assuming a fictional RatingBar widget
                RatingBar.builder(
                  initialRating: 0,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    // Tangkap nilai rating dan simpan di variabel atau state
                    setState(() {
                      _rating = rating!;
                    });
                    
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  "Review",
                  style: FontTheme.blackSubtitle(),
                ),
                const SizedBox(height: 8),
                // Modify the password TextField to be a multi-line TextField
                BookpalsTextField(
                  title: "Review",
                  hint: "Masukkan review",
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
                        text: "Add Review",
                        // onTap: () async {
                        //   if (_ratingController.text.isEmpty ||
                        //       _reviewController.text.isEmpty) {
                        //     setState(() {
                        //       errorMessage =
                        //           "Rating dan review harus di-isi!";
                        //     });
                        //     return;
                        //   }

                        //   setState(() {
                        //     isLoading = true;
                        //   });

                        //   final res = await auth.signIn(
                        //       _ratingController.text, _reviewController.text);

                        //   setState(() {
                        //     isLoading = false;
                        //   });

                        //   if (res["status"]) {
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) => const HomePage()),
                        //     );
                        //   } else {
                        //     setState(() {
                        //       errorMessage = res["message"];
                        //     });
                        //   }
                        // },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}