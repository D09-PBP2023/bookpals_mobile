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
    profileProvider.getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: EdgeInsets.all(20.0),
      child: Padding(
        padding: EdgeInsets.all(20.0),
        child: Provider<ProfileProvider>(
          create: (_) => ProfileProvider(),
          builder: (context, _) {
            final profileProvider = context.watch<ProfileProvider>();
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildProfilePicture(),
                SizedBox(height: 20.0),
                _buildName(profileProvider),
                SizedBox(height: 10.0),
                _buildEmail(),
                SizedBox(height: 10.0),
                _buildBio(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Container(
      width: 100.0,
      height: 100.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.blue, // Set your desired color
      ),
      child: Icon(
        Icons.person,
        size: 50.0,
        color: Colors.white,
      ),
    );
  }

  Widget _buildName(ProfileProvider profileProvider) {
    return Text(
      profileProvider.name,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 18.0,
      ),
    );
  }

  Widget _buildEmail() {
    return Text(
      'john.doe@example.com',
      style: TextStyle(
        color: Colors.grey,
      ),
    );
  }

  Widget _buildBio() {
    return Text(
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
      textAlign: TextAlign.center,
    );
  }
}
