import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:donut_app/pages/edit_profile.dart';
import 'package:donut_app/pages/login_page.dart';
import 'package:donut_app/pages/update_password_page.dart';
import 'package:donut_app/services/signout_service.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({super.key});

  @override
  State<UserInformation> createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Cargar los datos del usuario desde Firebase
  Future<void> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
        });
      }
    }
  }

  // Método para actualizar los datos cuando se regrese de la página de edición
  void _updateUserData(Map<String, dynamic> newData) {
    setState(() {
      userData = newData;
    });
  }

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
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 15),
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.black,
              child: userData != null && userData!['photoUrl'] != ''
                  ? CircleAvatar(
                radius: 43,
                backgroundImage: NetworkImage(userData!['photoUrl']),
                backgroundColor: Colors.white,
                onBackgroundImageError: (_, __) =>
                const Icon(Icons.error, size: 40),
              )
                  : const CircleAvatar(
                radius: 43,
                backgroundColor: Colors.white,
                child: Icon(Icons.person, size: 40),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              userData != null ? userData!['name'] ?? '' : '',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              userData != null ? '@${userData!['username'] ?? ''}' : '',
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),

            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Esperar a que se regrese de la página de edición y actualizar los datos
                final updatedData = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditProfilePage(),
                  ),
                );

                // Si se reciben datos actualizados, actualizamos el estado
                if (updatedData != null) {
                  _updateUserData(updatedData);
                }
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
              padding: const EdgeInsets.only(left: 60.0, top: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.settings_outlined,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Settings"),
                  ),
                  const SizedBox(width: 190),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0, top: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.featured_play_list_outlined,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("My Orders"),
                  ),
                  const SizedBox(width: 178),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 60.0, top: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Address"),
                  ),
                  const SizedBox(width: 190),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 60.0,
                top: 15.0,
                bottom: 15.0,
              ),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UpdatePasswordPage(),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      Icons.lock_clock_outlined,
                      color: Colors.black.withOpacity(0.5),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 10.0),
                      child: Text("Change Password"),
                    ),
                    const SizedBox(width: 127),
                    Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black.withOpacity(0.7),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(indent: 30, endIndent: 30),
            Padding(
              padding: const EdgeInsets.only(left: 60.0, top: 15.0),
              child: Row(
                children: [
                  Icon(
                    Icons.help_outline,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("Help & Support"),
                  ),
                  const SizedBox(width: 147),
                  Icon(
                    Icons.arrow_forward_ios_outlined,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 60.0,
                top: 15.0,
                bottom: 15.0,
              ),
              child: Row(
                children: [
                  GestureDetector(
                    child: Icon(
                      Icons.logout_outlined,
                      color: Colors.red.withOpacity(0.5),
                    ),
                    onTap: () async {
                      SignoutService auth = SignoutService();
                      await auth.signOut();

                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: GestureDetector(
                      child: const Text(
                        "Log Out",
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () async {
                        SignoutService auth = SignoutService();
                        await auth.signOut();

                        if (context.mounted) {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 193),
                  GestureDetector(
                    child: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.black.withOpacity(0.7),
                    ),
                    onTap: () async {
                      SignoutService auth = SignoutService();
                      await auth.signOut();

                      if (context.mounted) {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      }
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
}
