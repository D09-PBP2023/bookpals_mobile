import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:bookpals_mobile/core/bases/models/book.dart';
import 'package:bookpals_mobile/core/bases/widgets/button.dart';
import 'package:bookpals_mobile/core/bases/widgets/text_field.dart';
import 'package:bookpals_mobile/core/theme/color_theme.dart';
import 'package:bookpals_mobile/core/theme/font_theme.dart';

import '../../../core/bases/providers/review_provider.dart';

class ReviewFormPage extends StatefulWidget {
  final Book book;

  const ReviewFormPage(this.book, {super.key});

  @override
  State<ReviewFormPage> createState() => _ReviewFormPageState();
}

class _ReviewFormPageState extends State<ReviewFormPage> {
  final TextEditingController _reviewController = TextEditingController();
  double _rating = 0;
  late String errorMessage = "";

  @override
  Widget build(BuildContext context) {
    final reviewProvider = context.watch<ReviewProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book.fields.name}'),
        backgroundColor: ColorTheme.tanParchment,
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
                allowHalfRating: false,
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
                hint: "Share your thoughts!",
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
                      onTap: () async {
                        if (_rating == 0) {
                          setState(() {
                            errorMessage = "Rating missing!";
                          });
                          return;
                        }

                        final response = await reviewProvider.addReview(
                            _reviewController.text, _rating.toString(), widget.book.pk.toString());
                        
                        if (response['status'] == 'success') {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                            content: 
                                Text("Guide others to great reads. Share more reviews!"),
                            ));
                            reviewProvider.getAverageRating(widget.book.pk);
                            Navigator.pop(context);
                        } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                            content:
                                Text("There is an error, please try again."),
                            ));
                        }
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