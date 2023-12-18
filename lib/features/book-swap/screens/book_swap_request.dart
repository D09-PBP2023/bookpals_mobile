import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'book_swap.dart';
import '../../../core/bases/widgets/button.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/providers/book_provider.dart';
import 'package:bookpals_mobile/core/bases/models/Book.dart';

import 'package:bookpals_mobile/features/book-swap/providers/swap_provider.dart';

class RequestSwap extends StatefulWidget {
  const RequestSwap({super.key});

  @override
  State<RequestSwap> createState() => _RequestSwapState();
}

class _RequestSwapState extends State<RequestSwap> {
  List<Book> _books = <Book>[];
  String _fromMessage = "";
  String dropdownValueWant = "";
  String dropdownValueHave = "";
  bool checkedValue = false;
  Book? selectedBook;
  Book? selectedBook2;
  @override
  void initState() {
    super.initState();

    BookProvider bookProvider = context.read<BookProvider>();
    setState(() {
      _books = bookProvider.getAllBooks();
      dropdownValueWant = _books.first.fields.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    final swapProvider = context.watch<SwapProvider>();
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
        const SizedBox(height: 10),
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "Select a book you want to swap",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 10),
        // DropdownButton Wanted Book
        Row(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              child: DropdownButtonFormField<Book>(
                validator: (value) {
                  if (value == null) {
                    return 'Please select a book';
                  }
                  return null;
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                isExpanded: true,
                hint: Text("Select Book"),
                value: selectedBook,
                onChanged: (value) {
                  setState(() {
                    if (value != null) {
                      selectedBook = value;
                    }
                  });
                },
                items: _books.map<DropdownMenuItem<Book>>((Book value) {
                  return DropdownMenuItem<Book>(
                    value: value,
                    child: Container(
                        child: Text(
                      value.fields.name,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    )),
                  );
                }).toList(),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            // Add Search Button
          ],
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
        // Checkbox Have Book
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
        // DropdownButton Have Book
        if (checkedValue == true)
          Row(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.8,
                child: DropdownButtonFormField<Book>(
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a book';
                    }
                    return null;
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  isExpanded: true,
                  hint: Text("Select Book"),
                  value: selectedBook2,
                  onChanged: (value) {
                    setState(() {
                      if (value != null) {
                        selectedBook2 = value;
                      }
                    });
                  },
                  items: _books.map<DropdownMenuItem<Book>>((Book value) {
                    return DropdownMenuItem<Book>(
                      value: value,
                      child: Container(
                          child: Text(
                        value.fields.name,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      )),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        const SizedBox(height: 20),
        BpButton(
            text: "Request Swap",
            // Send Data to API
            onTap: () async {
              if (checkedValue) {
                final response = await swapProvider.swapRequest(
                  selectedBook!.fields.name,
                  selectedBook2!.fields.name,
                  _fromMessage,
                );

                if (response["status"]) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const BookSwap()),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        SnackBar(content: Text(response['message'])));
                } else {
                  setState(() {
                    print(response['message']);
                  });
                }
              } else {
                final response = await swapProvider.swapRequest(
                  selectedBook!.fields.name,
                  selectedBook2!.fields.name,
                  _fromMessage,
                );
                if (response["status"]) {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const BookSwap()),
                  );
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                        SnackBar(content: Text(response['message'])));
                } else {
                  setState(() {
                    print(response['message']);
                  });
                }
              }
            }),
        const SizedBox(height: 20)
      ],
    ));
  }
}
