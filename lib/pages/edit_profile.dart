import 'dart:io';

import 'package:donut_app/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  String? _imageUrl; // URL de la foto de perfil
  XFile? _pickerFile; // Imagen seleccionada

  @override
  void initState() {
    super.initState();
    // Cargar los datos del usuario
    _loadUserData();
  }

  // Cargar datos del usuario desde Firebase (suponiendo que ya tienes el ID del usuario)
  Future<void> _loadUserData() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (userDoc.exists) {
        setState(() {
          _nameController.text = userDoc['name'];
          _imageUrl = userDoc['photoUrl'];
        });
      }
    }
  }

  // Método para seleccionar la imagen de la galería
  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      setState(() {
        _pickerFile = pickedFile;
      });
    }
  }

  // Método para guardar los cambios
  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      String newName = _nameController.text.trim();
      String? newImageUrl;

      if (_pickerFile != null) {
        // Subir la foto a Supabase
        newImageUrl = await StorageService().uploadPhoto(
          _pickerFile!,
          FirebaseAuth.instance.currentUser!.uid,
        );
      }

      if (newImageUrl == null && _imageUrl == null) {
        // Si no hay imagen nueva y no se tiene una anterior
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Photo could not be uploaded')));
        return;
      }

      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Actualizar datos en Firebase
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
                'name': newName,
                'photoUrl': newImageUrl ?? _imageUrl,
                // Usa la URL de la foto nueva o la anterior
              });

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Profile updated correctly')));
        } catch (e) {
          print('Error al actualizar los datos del usuario: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al actualizar los datos')),
          );
        }
      }
    }
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
                "Edit Profile",
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
            const SizedBox(height: 50),
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 45,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 43,
                  backgroundColor: Colors.white,
                  child:
                      _pickerFile != null
                          ? ClipOval(
                            child: Image.file(
                              File(_pickerFile!.path),
                              width: 86,
                              height: 86,
                              fit: BoxFit.cover,
                            ),
                          )
                          : _imageUrl != null
                          ? ClipOval(
                            child: Image.network(
                              _imageUrl!,
                              width: 86,
                              height: 86,
                              fit: BoxFit.cover,
                            ),
                          )
                          : const Icon(Icons.person, size: 40),
                ),
              ),
            ),
            const SizedBox(height: 50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("New Name User", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    SizedBox(height: 15),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        hintText: 'Enter your full name',
                        hintStyle: TextStyle(color: Colors.grey[500]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true,
                        fillColor: Colors.grey[300],
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                    ),

                    const SizedBox(height: 50),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await _saveProfile(); // Guarda el perfil
                            Navigator.pop(
                              context,
                            ); // Regresa a la página anterior
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Save Changes'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
