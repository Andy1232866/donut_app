import 'package:donut_app/pages/edit_profile.dart';
import 'package:flutter/material.dart';

class UserInfo extends StatefulWidget {
  const UserInfo({super.key});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: EdgeInsets.only(right: 70.0),
              child: Text(
                "Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            const CircleAvatar(
              radius: 45,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 43,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Enrique Casanova",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            const Text(
              "@Enrique_Cas09",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text("Edit Profile"),
            ),
            const SizedBox(height: 15),
            const Divider(indent: 30, endIndent: 30),
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Settings"),
                  ),
                  SizedBox(width: 190),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black.withOpacity(0.7),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.featured_play_list_outlined,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("My Orders"),
                  ),
                  SizedBox(width: 178),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black.withOpacity(0.7),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Address"),
                  ),
                  SizedBox(width: 190),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black.withOpacity(0.7),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 15.0, bottom: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.lock_clock_outlined,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Change Password"),
                  ),
                  SizedBox(width: 127),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black.withOpacity(0.7),
                  )
                ],
              ),
            ),
            const Divider(indent: 30, endIndent: 30),
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Help & Support"),
                  ),
                  SizedBox(width: 147),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black.withOpacity(0.7),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.0, top: 15.0, bottom: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.logout_outlined,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Log Out"),
                  ),
                  SizedBox(width: 193),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black.withOpacity(0.7),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
