import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/models/Book.dart';
import '../../../core/bases/providers/BookProvider.dart';
import '../../../core/bases/providers/ProfileProvider.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/bases/models/Profile.dart';

import 'package:flutter/material.dart';

// masih rusak
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    ProfileProvider profileProvider = context.read<ProfileProvider>();
    profileProvider.setUserProfile();
    print("fuck you${profileProvider.userProfile.values}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = context.watch<ProfileProvider>();
    return Center(
      child: Card(
        elevation: 5.0,
        margin: EdgeInsets.all(20.0),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildProfilePicture(),
              SizedBox(height: 20.0),
              _buildName(profileProvider),
              SizedBox(height: 10.0),
              _buildEmail(profileProvider),
              SizedBox(height: 10.0),
              _buildBio(profileProvider),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue, // Set your desired color
      ),
      child: const Icon(
        Icons.person,
        size: 50.0,
        color: Colors.white,
      ),
    );
  }

  Widget _buildName(ProfileProvider profileProvider) {
    return Text(
      profileProvider.userProfile['fields']['nickname'],
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    );
  }

  Widget _buildEmail(ProfileProvider profileProvider) {
    return Text(
      profileProvider.userProfile['fields']['email'],
      style: const TextStyle(
        color: Colors.grey,
      ),
    );
  }

  Widget _buildBio(ProfileProvider profileProvider) {
    return Text(
      profileProvider.userProfile['fields']['bio'],
      textAlign: TextAlign.center,
    );
  }
}
