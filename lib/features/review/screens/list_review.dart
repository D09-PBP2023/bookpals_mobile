import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bookpals_mobile/core/theme/font_theme.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';


class ReviewPage extends StatefulWidget {
    const ReviewPage({super.key});

    @override
    State<ReviewPage> createState() => _ReviewPageState();
}

class _ReviewPageState extends State<ReviewPage> {
    @override
    Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Review List'),
      ),
      body: ListView.builder(
        itemCount: 5, // Ganti dengan jumlah review yang Anda miliki
        itemBuilder: (context, index) {
          return ReviewCard();
        },
      ),
    );
  }
}

class ReviewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                  'Review by username',
                  style: FontTheme.blackCaptionBold(),
                ),
                SizedBox(height: 8),
                // Rating Bar
                IgnorePointer(
                  child: RatingBar.builder(
                    initialRating: 3,
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
                  '2023-12-06',
                  style: FontTheme.blackCaption(),
                ),
                
                SizedBox(height: 8),
                // Lorem Ipsum Text
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras at malesuada massa, id vestibulum magna. Curabitur dapibus condimentum felis et mattis. Maecenas efficitur nulla orci, nec placerat erat pellentesque non. Quisque aliquet convallis quam, ac finibus sem',
                  style: FontTheme.blackCaption(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}