import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/providers/profile_provider.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/theme/color_theme.dart';

class EditProfile extends StatefulWidget {
  final ProfileProvider profileProvider;
  final String? name, email, bio;

  const EditProfile(
      {super.key,
      required this.profileProvider,
      this.name,
      this.email,
      this.bio});
  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  String _email = "";
  String _bio = "";

  @override
  void initState() {
    _name = widget.name ?? "";
    _email = widget.email ?? "";
    _bio = widget.bio ?? "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    return BpScaffold(
      appBar: AppBar(
        title: const Text(
          'Edit Profile',
        ),
        backgroundColor: ColorTheme.tanParchment,
        foregroundColor: Colors.black,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // TODO: Tambahkan drawer yang sudah dibuat di sini
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Nama",
                  labelText: "Nama",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                initialValue: _name,
                onChanged: (String? value) {
                  setState(() {
                    _name = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "Nama tidak boleh kosong!";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Email",
                  labelText: "Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                initialValue: _email,
                onChanged: (String? value) {
                  setState(() {
                    // TODO: Tambahkan variabel yang sesuai
                    _email = value!;
                  });
                },
                validator: (String? value) {
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  hintText: "Bio",
                  labelText: "Bio",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                initialValue: _bio,
                onChanged: (String? value) {
                  setState(() {
                    // TODO: Tambahkan variabel yang sesuai
                    _bio = value!;
                  });
                },
                validator: (String? value) {
                  return null;
                },
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: 60,
                width: 120,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await profileProvider.editUserProfile(
                          _name, _email, _bio);
                      await profileProvider.setUserProfile();
                      Navigator.pop(context);
                    },
                    child: const Text("Submit"),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
