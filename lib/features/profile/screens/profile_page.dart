import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/bases/providers/book_provider.dart';
import '../../../core/bases/providers/profile_provider.dart';
import '../../../core/bases/widgets/button.dart';
import '../../../core/bases/widgets/scaffold.dart';
import '../../../core/theme/color_theme.dart';
import '../../authentication/providers/auth_provider.dart';

import '../../authentication/screens/login_page.dart';
import 'edit_profile_page.dart';
import 'widgets/bookmark_edit.dart';

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
    BookProvider bookProvider = context.read<BookProvider>();
    bookProvider.fetchAllBook();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = context.watch<BookProvider>();
    final profileProvider = context.watch<ProfileProvider>();
    final auth = context.watch<AuthProvider>();

    return BpScaffold(
      backgroundColor: ColorTheme.morningDew,
      padding: const EdgeInsets.only(left: 24, right: 24, top: 20),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildComplete(profileProvider),
            Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                width: 100,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfile(
                          profileProvider: profileProvider,
                        ),
                      ),
                    );
                    setState(() {
                      profileProvider.setUserProfile();
                    });
                  },
                  child: const Text("Edit"),
                ),
              ),
            ),
            const SizedBox(height: 10),

            // Add some extra space
            Container(
              padding: const EdgeInsets.only(
                  bottom: 5.0), // Adjust the bottom padding as needed
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 210,
                    width: 1000,
                    child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color.fromARGB(255, 151, 67, 41),
                              Color.fromARGB(255, 119, 40, 27)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                              color: const Color.fromARGB(255, 67, 36, 25),
                              width: 1.0),
                        ),
                        child: Row(
                          children: [
                            _bookCover1(bookProvider, profileProvider),
                            _bookCover2(bookProvider, profileProvider),
                            _bookCover3(bookProvider, profileProvider),
                          ],
                        )),
                  ),
                  const SizedBox(height: 50),
                  BpButton(
                    text: "Logout",
                    onTap: () async {
                      await auth.logout();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignInPage(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _bookCover1(
      BookProvider bookProvider, ProfileProvider profileProvider) {
    int x = profileProvider.userProfile.fields.favoriteBook1;
    if (x != 0) {
      x--;
    }
    return Expanded(
      child: Container(
        height: double.infinity, // Take up the entire height of the parent Row
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255), // Set border color
            width: 1.0, // Set border width
            style: BorderStyle.solid, // Set border style to dotted
          ),
        ),
        margin: const EdgeInsets.all(15.0),
        // Add some margin between rectangles

        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookmarkEdit(
                  profileProvider: profileProvider,
                  x: 1,
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              bookProvider.listBook[x].fields
                  .coverImage, // Replace with the actual URL of your image
              fit: BoxFit
                  .cover, // You can adjust the fit based on your requirements
            ),
          ),
        ),
      ),
    );
  }

  Widget _bookCover2(
      BookProvider bookProvider, ProfileProvider profileProvider) {
    int x = profileProvider.userProfile.fields.favoriteBook2;
    if (x != 0) {
      x--;
    }
    return Expanded(
      child: Container(
        height: double.infinity, // Take up the entire height of the parent Row
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255), // Set border color
            width: 1.0, // Set border width
            style: BorderStyle.solid, // Set border style to dotted
          ),
        ),
        margin: const EdgeInsets.all(15.0),
        // Add some margin between rectangles
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookmarkEdit(
                  profileProvider: profileProvider,
                  x: 2,
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              bookProvider.listBook[x].fields
                  .coverImage, // Replace with the actual URL of your image
              fit: BoxFit
                  .cover, // You can adjust the fit based on your requirements
            ),
          ),
        ),
      ),
    );
  }

  Widget _bookCover3(
      BookProvider bookProvider, ProfileProvider profileProvider) {
    int x = profileProvider.userProfile.fields.favoriteBook3;
    if (x != 0) {
      x--;
    }
    return Expanded(
      child: Container(
        height: double.infinity, // Take up the entire height of the parent Row
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: const Color.fromARGB(255, 255, 255, 255), // Set border color
            width: 1.0, // Set border width
            style: BorderStyle.solid, // Set border style to dotted
          ),
        ),
        margin: const EdgeInsets.all(15.0),
        // Add some margin between rectangles
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => BookmarkEdit(
                  profileProvider: profileProvider,
                  x: 3,
                ),
              ),
            );
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              bookProvider.listBook[x].fields
                  .coverImage, // Replace with the actual URL of your image
              fit: BoxFit
                  .cover, // You can adjust the fit based on your requirements
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNameEmailBio(ProfileProvider profileProvider) {
    return Padding(
      padding: const EdgeInsets.only(top: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildName(profileProvider),
          const SizedBox(
              height: 10.0), // Adjust the space between email and bio
          _buildEmail(profileProvider),
          const SizedBox(
            height: 20.0,
          ),
          _buildBio(profileProvider)
        ],
      ),
    );
  }

  Widget _buildProfilePicture() {
    return Padding(
      padding: const EdgeInsets.only(
          bottom: 60.0), // Adjust the top padding as needed
      child: Container(
        width: MediaQuery.of(context).size.width * (0.3),
        height: MediaQuery.of(context).size.width * (0.3),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.blue, // Set your desired color
        ),
        child: const Icon(
          Icons.person,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildName(ProfileProvider profileProvider) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Text(
        profileProvider.userProfile.fields.nickname,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 18.0,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Widget _buildEmail(ProfileProvider profileProvider) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      child: Text(
        profileProvider.userProfile.fields.email,
        style: const TextStyle(
            color: Colors.grey, backgroundColor: Colors.amberAccent),
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
      ),
    );
  }

  Widget _buildBio(ProfileProvider profileProvider) {
    return Container(
      width: MediaQuery.of(context).size.width *
          (0.45), // Adjust the width as needed
      height: 150.0,
      decoration: BoxDecoration(
        color: Colors.grey[200], // Light gray background
        borderRadius:
            BorderRadius.circular(12.0), // Adjust the border radius as needed
        border: Border.all(color: Colors.blue, width: 2.0), // Blue outline
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0), // Adjust the margin as needed
        child: Text(
          profileProvider.userProfile.fields.bio,
          textAlign: TextAlign.left,
          style: const TextStyle(
            color: Colors.black,
            backgroundColor:
                Colors.transparent, // Set the background color of the text
          ),
        ),
      ),
    );
  }

  Widget _buildComplete(ProfileProvider profileProvider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 60.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildProfilePicture(),
          const SizedBox(
              width: 10.0), // Adjust the space between profile picture and name
          _buildNameEmailBio(profileProvider),
        ],
      ),
    );
  }
}
