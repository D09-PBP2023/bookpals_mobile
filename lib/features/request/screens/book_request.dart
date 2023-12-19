import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class BookRequest {
  final int id;
  final String bookTitle;
  final String requestStatus;

  BookRequest({required this.id, required this.bookTitle, required this.requestStatus});

  factory BookRequest.fromJson(Map<String, dynamic> json) {
    return BookRequest(
      id: json['id'],
      bookTitle: json['book_title'],
      requestStatus: json['request_status'],
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Request',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BookRequestScreen(),
    );
  }
}

class BookRequestScreen extends StatefulWidget {
  @override
  _BookRequestScreenState createState() => _BookRequestScreenState();
}

class _BookRequestScreenState extends State<BookRequestScreen> {
  late List<BookRequest> requests = [];

  Future<void> fetchRequests() async {
    final response = await http.get(Uri.parse('http://your-django-backend-url/requests/'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      setState(() {
        requests = data.map((item) => BookRequest.fromJson(item)).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRequests();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Requests'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              // Add logic to request a book
            },
            child: Text('Request a Book'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: DataTable(
              columns: const <DataColumn>[
                DataColumn(label: Text('ID')),
                DataColumn(label: Text('Book Title')),
                DataColumn(label: Text('Status')),
              ],
              rows: requests.map((request) {
                return DataRow(
                  cells: <DataCell>[
                    DataCell(Text('${request.id}')),
                    DataCell(Text(request.bookTitle)),
                    DataCell(Text(request.requestStatus)),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
