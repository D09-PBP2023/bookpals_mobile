import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:bookpals_mobile/core/bases/models/book.dart';
import 'package:bookpals_mobile/core/theme/color_theme.dart';
import 'package:bookpals_mobile/core/theme/font_theme.dart';
import 'package:bookpals_mobile/features/request/models/request.dart';
import 'package:bookpals_mobile/services/api.dart';

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
        drawer: const LeftDrawer(),
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
