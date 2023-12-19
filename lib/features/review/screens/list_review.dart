import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:bookpals_mobile/core/bases/models/book.dart';
import 'package:bookpals_mobile/core/theme/color_theme.dart';
import 'package:bookpals_mobile/core/theme/font_theme.dart';
import 'package:bookpals_mobile/features/review/models/review.dart';
import 'package:bookpals_mobile/services/api.dart';

import 'package:provider/provider.dart';
import '../../../../core/bases/providers/review_provider.dart';

class ReviewPage extends StatefulWidget {
    final Book book; // Accept Book as a parameter

    const ReviewPage(this.book, {super.key});

    @override
    State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  bool _isLoading = true;

  @override
  void initState() {
    ReviewProvider reviewProvider = context.read<ReviewProvider>();
    reviewProvider.fetchReview(widget.book.pk).then((value) {
      setState(() {
        _isLoading = false;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reviewProvider = context.watch<ReviewProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book.fields.name}'),
        backgroundColor: ColorTheme.tanParchment,
      ),
      body: _isLoading
        ? const Center(child: CircularProgressIndicator())
        : reviewProvider.listReview.isEmpty
          ? Center(
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "No reviews yet.",
                        style: TextStyle(
                          color: ColorTheme.coffeeGrounds,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Share your insights and light up the page!",
                        style: TextStyle(
                          color: ColorTheme.coffeeGrounds,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
            )
            : ListView.builder(
                itemCount: reviewProvider.listReview.length,
                itemBuilder: (context, index) => 
                Container(
                  margin: EdgeInsets.all(8),
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Icon(
                          Icons.person,
                          size: 30,
                          color: Colors.white,
                        ),
                        backgroundColor: ColorTheme.almondDust,
                        radius: 30,
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Review by ${reviewProvider.listReview[index].user}',
                              style: FontTheme.blackCaptionBold(),
                            ),
                            SizedBox(height: 8),
                            IgnorePointer(
                              child: RatingBar.builder(
                                initialRating: reviewProvider.listReview[index].rating.toDouble(),
                                itemCount: 5,
                                itemSize: 20,
                                direction: Axis.horizontal,
                                allowHalfRating: false,
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                                onRatingUpdate: (rating) {
                                  // Do nothing or provide a dummy function
                                },
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              DateFormat('yyyy-MM-dd').format(reviewProvider.listReview[index].created_at),
                              style: FontTheme.blackCaption(),
                            ),
                            SizedBox(height: 8),
                            Text(
                              '${reviewProvider.listReview[index].review}',
                              style: FontTheme.blackCaption(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
    );
  }
}
