import 'package:flutter/material.dart';

import '../../../core/bases/widgets/button.dart';
import '../../../core/bases/widgets/scaffold.dart';
import 'package:bookpals_mobile/core/bases/models/Book.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:bookpals_mobile/core/environments/endpoints.dart';

class RequestSwap extends StatefulWidget {
  const RequestSwap({super.key});

  @override
  State<RequestSwap> createState() => _RequestSwapState();
}

class _RequestSwapState extends State<RequestSwap> {
  List<Book> books = [];
  String _fromMessage = "";
  String dropdownValueWant = "";
  String dropdownValueHave = "";
  bool checkedValue = false;

  Future<void> fetchBooks() async {
    final response = await http.get(Uri.parse(Endpoints.getBooksUrl));

    if (response.statusCode == 200) {
      String body = utf8.decode(response.bodyBytes);
      setState(() {
        books = (jsonDecode(body) as List)
            .map((data) => Book.fromJson(data))
            .toList();
        dropdownValueWant = books[0].fields.name;
      });
    } else {
      throw Exception('Failed to load books');
    }
  }

  final int maxLength = 20;
  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return BpScaffold(
        body: Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Request Swap",
            style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),

        const SizedBox(height: 20),
        DropdownMenu<Book>(
          initialSelection: books.first,
          onSelected: (Book? value) {
            setState(() {
              if (value != null) {
                dropdownValueWant = value.fields.name;
              }
            });
          },
          label: const Text("Want Book"),
          dropdownMenuEntries: books.map<DropdownMenuEntry<Book>>((Book value) {
            return DropdownMenuEntry<Book>(
              value: value,
              label: value.fields.name,
            );
          }).toList(),
        ),
        const SizedBox(height: 20),
        // TextField Message
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          },
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Message',
          ),
          onChanged: (value) {
            setState(() {
              _fromMessage = value;
            });
          },
        ),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text("Have a Book? "),
          //Checkbox
          Checkbox(
            value: checkedValue,
            onChanged: (bool? value) {
              setState(() {
                checkedValue = value!;
              });
            },
          ),
        ]),
        if (checkedValue == true)
          DropdownMenu<Book>(
            initialSelection: books.first,
            onSelected: (Book? value) {
              setState(() {
                if (value != null) {
                  dropdownValueHave = value.fields.name;
                }
              });
            },
            dropdownMenuEntries:
                books.map<DropdownMenuEntry<Book>>((Book value) {
              return DropdownMenuEntry<Book>(
                  value: value, label: value.fields.name);
            }).toList(),
          ),
        const SizedBox(height: 20),
        BpButton(
            text: "Request Swap",
            // Send Data to API
            onTap: () {}),
        const SizedBox(height: 20),
      ],
    ));
  }
}
