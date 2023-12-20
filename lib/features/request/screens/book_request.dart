import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/widgets/custom_icon_icons.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../providers/bookrequest_provider.dart';

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

    return BpScaffold(
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(
                      CustomIcon.book_open,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Bookpals",
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Book Request",
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
          ),
          const SizedBox(height: 20),
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
                                initAspectRatio: CropAspectRatioPreset.original,
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
                          // ignore: unused_local_variable
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
                              builder: (context) => const BookRequestScreen()),
                        );
                        ScaffoldMessenger.of(context)
                          ..hideCurrentSnackBar()
                          ..showSnackBar(
                              SnackBar(content: Text(response['message'])));
                      } else {
                        setState(() {
                          // ignore: unused_local_variable
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
    );
  }
}
