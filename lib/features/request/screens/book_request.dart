import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookRequestScreen extends StatefulWidget {
  @override
  _BookRequestScreenState createState() => _BookRequestScreenState();
}

class _BookRequestScreenState extends State<BookRequestScreen> {
  bool _showForm = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController authorController = TextEditingController();
  TextEditingController originalLanguageController = TextEditingController();
  TextEditingController yearPublishedController = TextEditingController();
  TextEditingController salesController = TextEditingController();
  TextEditingController genreController = TextEditingController();
  // TODO: ADD CONTROLLER BUAT COVER IMAGE

  List<Map<String, dynamic>> requestedBooks = [];

  Future<void> makeBookRequest() async {
    var apiUrl = Uri.parse('http://127.0.0.1:8000/request_book_by_ajax');

    var response = await http.post(apiUrl, body: {
      'name': nameController.text,
      'author': authorController.text,
      'original_language': originalLanguageController.text,
      'year_published': yearPublishedController.text,
      'sales': salesController.text,
      'genre': genreController.text,
      // TODO: ADD YG BUAT COVER IMAGE
    });

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      setState(() {
        requestedBooks.add({
          'name': responseData['name'],
          'author': responseData['author'],
          'original_language': responseData['original_language'],
          'year_published': responseData['year_published'],
          'sales': responseData['sales'],
          'genre': responseData['genre'],
          // TODO: ADD YG BUAT COVER IMAGE
        });
      });
    } else {
      print('Failed to make a book request.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Request'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _showForm = true;
                });
              },
              child: Text('Add Request'),
            ),
            if (_showForm)
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(labelText: 'Book Name'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the book name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: authorController,
                      decoration: InputDecoration(labelText: 'Author'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the author';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: originalLanguageController,
                      decoration: InputDecoration(labelText: 'Original Language'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the original language';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: yearPublishedController,
                      decoration: InputDecoration(labelText: 'Year Published'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the year published';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: salesController,
                      decoration: InputDecoration(labelText: 'Sales'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the number of sales';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: genreController,
                      decoration: InputDecoration(labelText: 'Genre'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter the genre';
                        }
                        return null;
                      },
                    ),
                    // TODO: TAMBAHIN YG BUAT COVER IMAGE

                    ElevatedButton(
                      onPressed: makeBookRequest,
                      child: Text('Submit Request'),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: ListView.builder(
                itemCount: requestedBooks.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(requestedBooks[index]['name']),
                    subtitle: Text(requestedBooks[index]['author']),
                    subtitle: Text(requestedBooks[index]['original_language']),
                    subtitle: Text(requestedBooks[index]['year_published']),
                    subtitle: Text(requestedBooks[index]['sales']),
                    subtitle: Text(requestedBooks[index]['genre']),
                    // TODO: TAMBAHIN YG BUAT COVER IMAGE
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}