import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:bookpals_mobile/core/bases/models/Book.dart';
import 'package:bookpals_mobile/core/theme/font_theme.dart';
import 'package:bookpals_mobile/features/review/models/review.dart';
import 'package:bookpals_mobile/services/api.dart';

class ReviewPage extends StatefulWidget {
    final Book book; // Accept Book as a parameter

    const ReviewPage(this.book);

    @override
    State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
  Future<List<Review>> fetchReview() async {
    final response = await APIHelper.get(
      'http://127.0.0.1:8000/get_review/${widget.book.pk}/',
    );

    List<Review> list_review = [];
    for (var d in response) {
        if (d != null) {
            list_review.add(Review.fromJson(d));
        }
    }
    return list_review;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.book.fields.name}'),
      ),
      body: FutureBuilder(
        future: fetchReview(),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData || snapshot.data.isEmpty) {
              return Center(
                child: Text(
                  "No reviews yet.",
                  style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => 
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
                      // Profile Picture
                      CircleAvatar(
                      // Ganti dengan gambar profil
                        backgroundImage: AssetImage('assets/profile_picture.png'),
                        radius: 30,
                      ),
                      SizedBox(width: 16),
                      // Informasi Review
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text "Review by username"
                            Text(
                              'Review by ${snapshot.data![index].user}',
                              style: FontTheme.blackCaptionBold(),
                            ),
                            SizedBox(height: 8),
                            // Rating Bar
                            IgnorePointer(
                              child: RatingBar.builder(
                                initialRating: snapshot.data![index].rating,
                                itemCount: 5,
                                itemSize: 20,
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
                            // Tanggal
                            Text(
                              DateFormat('yyyy-MM-dd').format(snapshot.data![index].created_at),
                              style: FontTheme.blackCaption(),
                            ),       
                            SizedBox(height: 8),
                            // Review Text
                            Text(
                              '${snapshot.data![index].review}',
                              style: FontTheme.blackCaption(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              );      
            }
          }
        }        
      )
    );  
  }
}