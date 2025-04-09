import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
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
                "Edit Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 15),
            CircleAvatar(
              radius: 45,
              backgroundColor: Colors.black,
              child: CircleAvatar(
                radius: 43,
                backgroundColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Enrique Casanova",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
            ),
            Text(
              "@Enrique_Cas09",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 20),
            Divider(indent: 30, endIndent: 30),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: Form(
                  key: _formKey,
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Full name',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.0,
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintText: 'Enter your full name',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        )
                      ],
                    ),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
