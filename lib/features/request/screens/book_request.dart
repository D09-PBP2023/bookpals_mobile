import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:provider/provider.dart';
import '../../bookrequest_provider.dart';

class BookRequestScreen extends StatefulWidget {
  const BookRequestScreen({Key? key}) : super(key: key);
  @override
  _BookRequestScreenState createState() => _BookRequestScreenState();
}

class _BookRequestScreenState extends State<BookRequestScreen> {
  bool _showForm = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _authorController = TextEditingController();
  TextEditingController _originalLanguageController = TextEditingController();
  TextEditingController _yearPublishedController = TextEditingController();
  TextEditingController _salesController = TextEditingController();
  TextEditingController _genreController = TextEditingController();
  // TODO: ADD CONTROLLER BUAT COVER IMAGE

  List<Map<String, dynamic>> requestedBooks = [];

  @override
  Widget build(BuildContext context) {
    final req = context.watch<BookRequestProvider>();

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
              onPressed: () async{
                _showForm = true;
                if(_nameController.text.isEmpty || 
                   _authorController.text.isEmpty ||
                   _originalLanguageController.text.isEmpty ||
                   _genreController.text.isEmpty ||
                   _salesController.text.isEmpty ||
                   _yearPublishedController.text.isEmpty){
                  setState((){
                    errorMessage = "Semua fields harus diisi!";
                  });
                  return;  
                }
                final response = await req.makeRequest(
                  _nameController.text,
                  _authorController.text,
                  _originalLanguageController.text,
                  _yearPublishedController.text,
                  _salesController.text,
                  _genreController.text,
                );
              if(response["status"]){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BookRequestScreen()),
                );
                ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(response['message'])));
              }
              else{
                setState((){
                  errorMessage = response['message'];
                });
              }
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
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Book Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the book name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _authorController,
                      decoration: InputDecoration(labelText: 'Author'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the author';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: originalLanguageController,
                      decoration:
                          InputDecoration(labelText: 'Original Language'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the original language';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: yearPublishedController,
                      decoration: InputDecoration(labelText: 'Year Published'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the year published';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: salesController,
                      decoration: InputDecoration(labelText: 'Sales'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the number of sales';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: genreController,
                      decoration: InputDecoration(labelText: 'Genre'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the genre';
                        }
                        return null;
                      },
                    ),
                    // TODO: TAMBAHIN YG BUAT COVER IMAGE

                    ElevatedButton(
                      onPressed: () {
                        //submit request
                      },
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
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Author: ${requestedBooks[index]['author']}'),
                        Text(
                            'Original Language: ${requestedBooks[index]['original_language']}'),
                        Text(
                            'Year Published: ${requestedBooks[index]['year_published']}'),
                        Text('Sales: ${requestedBooks[index]['sales']}'),
                        Text('Genre: ${requestedBooks[index]['genre']}'),
                        // Add more Text widgets for additional subtitles
                      ],
                    ),
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