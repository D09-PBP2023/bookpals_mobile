import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../providers/bookrequest_provider.dart';
import '../providers/submitrequest_provider.dart';
import '../providers/getrequest_provider.dart';


class BookRequestScreen extends StatefulWidget {
  const BookRequestScreen({Key? key}) : super(key: key);
  @override
  _BookRequestScreenState createState() => _BookRequestScreenState();
}

class _BookRequestScreenState extends State<BookRequestScreen> {
  bool _showForm = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _authorController = TextEditingController();
  final TextEditingController _originalLanguageController =
      TextEditingController();
  final TextEditingController _yearPublishedController =
      TextEditingController();
  final TextEditingController _salesController = TextEditingController();
  final TextEditingController _genreController = TextEditingController();
  CroppedFile? coverFile;

  List<Map<String, dynamic>> requestedBooks = [];

  @override
  Widget build(BuildContext context) {
    final req = context.watch<BookRequestProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Request'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  _showForm = true;
                });
              },
              child: const Text('Add Request'),
            ),
            if (_showForm)
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(labelText: 'Book Name'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the book name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _authorController,
                      decoration: const InputDecoration(labelText: 'Author'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the author';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _originalLanguageController,
                      decoration:
                          const InputDecoration(labelText: 'Original Language'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the original language';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _yearPublishedController,
                      decoration:
                          const InputDecoration(labelText: 'Year Published'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the year published';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _salesController,
                      decoration: const InputDecoration(labelText: 'Sales'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the number of sales';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _genreController,
                      decoration: const InputDecoration(labelText: 'Genre'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter the genre';
                        }
                        return null;
                      },
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final ImagePicker picker = ImagePicker();
                        // Pick an image.
                        final XFile? image =
                            await picker.pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          CroppedFile? croppedFile =
                              await ImageCropper().cropImage(
                            sourcePath: image.path,
                            aspectRatio:
                                const CropAspectRatio(ratioX: 9, ratioY: 16),
                            uiSettings: [
                              AndroidUiSettings(
                                  toolbarTitle: 'Cropper',
                                  toolbarColor: Colors.deepOrange,
                                  toolbarWidgetColor: Colors.white,
                                  initAspectRatio:
                                      CropAspectRatioPreset.original,
                                  lockAspectRatio: true),
                              IOSUiSettings(
                                title: 'Cropper',
                              ),
                              WebUiSettings(
                                context: context,
                              ),
                            ],
                          );
                          if (croppedFile != null) {
                            setState(() {
                              coverFile = croppedFile;
                            });
                          }
                        }
                      },
                      child: const Text(
                        "Upload Cover",
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_nameController.text.isEmpty ||
                            _authorController.text.isEmpty ||
                            _originalLanguageController.text.isEmpty ||
                            _genreController.text.isEmpty ||
                            _salesController.text.isEmpty ||
                            _yearPublishedController.text.isEmpty ||
                            coverFile == null) {
                          setState(() {
                            var errorMessage = "Semua fields harus diisi!";
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
                          coverFile!,
                        );
                        if (response["status"]) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const BookRequestScreen()),
                          );
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                                SnackBar(content: Text(response['message'])));
                        } else {
                          setState(() {
                            var errorMessage = response['message'];
                          });
                        }
                      },
                      child: const Text('Submit Request'),
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

class RequestPage extends StatefulWidget {
    const RequestPage({Key? key}) : super(key: key);

    @override
    _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
Future<List<Request>> fetchProduct() async {
    var url = Uri.parse(
        'http://127.0.0.1:8000/get-requested-book/');
    var response = await http.get(
        url,
        headers: {"Content-Type": "application/json"},
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object Product
    List<Request> list_request = [];
    for (var d in data) {
        if (d != null) {
            list_request.add(Request.fromJson(d));
        }
    }
    return list_request;
}

@override
Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text('Requests'),
        ),
        body: FutureBuilder(
            future: fetchProduct(),
            builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                } else {
                    if (!snapshot.hasData) {
                    return const Column(
                        children: [
                        Text(
                            "Tidak ada request.",
                            style:
                                TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                        ),
                        SizedBox(height: 8),
                        ],
                    );
                } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    Text(
                                    "${snapshot.data![index].fields.name}",
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                    ),
                                ],
                                ),
                            ));
                    }
                }
            }));
    }
}