import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../main/screens/home_page.dart';
import '../../../core/bases/widgets/button.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/providers/book_provider.dart';
import '../../../core/bases/models/Book.dart';

import '../../../features/book-swap/providers/swap_provider.dart';
import 'book_swap.dart';

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
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
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
            "Select a book you that want to swap",
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
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
                isExpanded: true,
                hint: const Text("Select Book"),
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
            const SizedBox(
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
                  style: const TextStyle(
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
              if (_fromMessage == "") {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Your message is empty"),
                        content: const Text("Please enter a message"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("OK"))
                        ],
                      );
                    });
                return;
              } else {
                if (selectedBook == null) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("You have not selected a book"),
                          content: const Text("Please select a book"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("OK"))
                          ],
                        );
                      });
                  return;
                } else {
                  if (checkedValue) {
                    if (selectedBook2 == null) {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(
                                  "You have not selected a book you have"),
                              content: const Text("Please select a book"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Text("OK"))
                              ],
                            );
                          });
                      return;
                    } else {
                      final response = await swapProvider
                          .swapRequest(
                            selectedBook!.fields.name,
                            selectedBook2!.fields.name,
                            _fromMessage,
                          )
                          .whenComplete(() => setState(
                                () {
                                  swapProvider.fetchProcessedSwap();
                                },
                              ))
                          .whenComplete(() {
                        setState(() {});
                        // Back to SwapPage
                        Navigator.pop(context);
                      });
                    }
                    // Navigate to SwapPage
                  } else {
                    final response = await swapProvider
                        .swapRequest(
                          selectedBook!.fields.name,
                          "",
                          _fromMessage,
                        )
                        .whenComplete(() => setState(
                              () {
                                swapProvider.fetchProcessedSwap();
                              },
                            ))
                        .whenComplete(() {
                      setState(() {});
                      Navigator.pop(context);
                    });
                    // Navigate to SwapPage
                  }
                }
              }
            }),
        const SizedBox(height: 20)
      ],
    ));
  }
}
