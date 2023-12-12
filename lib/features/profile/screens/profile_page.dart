import 'package:flutter/material.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:provider/provider.dart';

import '../models/user_profile.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  _ProfilePageState();

  Future<List<UserProfile>> fetchProduct(CookieRequest request) async {
    final response = await request.get(
      "https://127.0.0.1:8000/profileflutter/",
    );
    List<UserProfile> list_profile = [];
    for (var d in response) {
      if (d != null) {
        list_profile.add(UserProfile.fromJson(d));
      }
    }
    return list_profile;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pengembalian UserProfile',
          ),
          foregroundColor: const Color.fromARGB(255, 42, 33, 0),
          backgroundColor: const Color(0xFFC9C5BA),
        ),
        body: FutureBuilder(
          future: fetchProduct(request),
          builder: (context, AsyncSnapshot<List<UserProfile>> snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return const Column(
                  children: [
                    Text(
                      "Tidak ada data produk.",
                      style: TextStyle(
                          color: Color.fromARGB(255, 42, 33, 0), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: 1,
                    itemBuilder: (_, index) => Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 12),
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(8.0),
                                  topRight: Radius.circular(8.0),
                                ),
                                child: Image.network(
                                  snapshot.data![index].fields.profilePicture,
                                  width: 200,
                                  height: 250,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                  "email : ${snapshot.data![index].fields.email}"),
                              const SizedBox(height: 10),
                              Text("bio : ${snapshot.data![index].fields.bio}"),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                onPressed: () {},
                                child: null,
                              )
                            ],
                          ),
                        ));
              }
            }
          },
        ));
  }
}
