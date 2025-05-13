import 'dart:io';

import 'package:donut_app/services/storage_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  /// Página para edición del perfil de usuario.
  ///
  /// Permite al usuario:
  /// 1. Cambiar su nombre de perfil
  /// 2. Actualizar su foto de perfil
  /// 3. Guardar los cambios en Firebase
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>(); // Clave para validar el formulario
  final TextEditingController _nameController = TextEditingController();  // Controlador para el campo de nombre
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
    // Obtiene el usuario actualmente autenticado en Firebase Auth
    // Retorna null si no hay sesión activa
    final user = FirebaseAuth.instance.currentUser;
    // Verifica si existe un usuario logueado
    if (user != null) {
      // Accede a Firestore para obtener los datos adicionales del usuario
      // La consulta busca en la colección 'users' el documento con el UID del usuario
      final userDoc =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get(); // Operación asincrónica que obtiene el documento
       // Verifica si el documento del usuario existe en Firestore
      if (userDoc.exists) {
        // Actualiza el estado del widget con los nuevos datos
        setState(() {
          _nameController.text = userDoc['name']; // Establece el nombre actual
          _imageUrl = userDoc['photoUrl'];  // Establece la URL de la foto actual
        });
      }
    }
  }

  // Método para seleccionar la imagen de la galería
  Future<void> _pickImage() async {
    // Crea una instancia de ImagePicker
    final ImagePicker _picker = ImagePicker();
    // Abre el selector de imágenes y espera a que el usuario seleccione una
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery, // Especifica que se usará la galería
    );
    // Si el usuario seleccionó un archivo válido
    if (pickedFile != null) {
    // Actualiza el estado del widget con el nuevo archivo
      setState(() {
        _pickerFile = pickedFile; // Almacena el archivo seleccionado para su posterior uso
      });
    }
  }

  // Método para guardar los cambios
  Future<void> _saveProfile() async {
      // Valida los campos del formulario antes de proceder
    if (_formKey.currentState!.validate()) {
      // Obtiene el nombre del campo de texto, eliminando espacios innecesarios
      String newName = _nameController.text.trim();

      // Variable para almacenar la nueva URL de imagen (si se sube una nueva)
      String? newImageUrl;
      // Si el usuario seleccionó una nueva imagen
      if (_pickerFile != null) {
        // Subir la foto a Supabase
        newImageUrl = await StorageService().uploadPhoto(
          _pickerFile!,
          FirebaseAuth.instance.currentUser!.uid,
        );
      }
      // Validación de seguridad: asegura que haya al menos una imagen (nueva o existente)
      if (newImageUrl == null && _imageUrl == null) {
        // Si no hay imagen nueva y no se tiene una anterior
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Photo could not be uploaded')));
        return; // Detiene la ejecución
      }
      // Obtiene el usuario actualmente autenticado
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        // Actualizar datos en Firebase
        try {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .update({
                'name': newName,  // Nuevo nombre
                'photoUrl': newImageUrl ?? _imageUrl,// Usa nueva URL o mantiene la existente
                // Usa la URL de la foto nueva o la anterior
              });
          // Muestra confirmación de actualización exitosa
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Profile updated correctly')));
        } catch (e) {
          // Manejo de errores: imprime en consola y muestra mensaje al usuario
          print('Error al actualizar los datos del usuario: $e');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error al actualizar los datos')),
          );
        }
      }
    }
  }
/// Construye la interfaz de usuario para editar el perfil
/// Incluye:
/// - AppBar con título centrado
/// - Selector de imagen circular
/// - Formulario para editar nombre
/// - Botón de guardar cambios
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       // Barra superior de la aplicación
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround, // Distribución del espacio
          children: [
            Padding(
              padding: EdgeInsets.only(right: 70.0), // Ajuste visual para centrado
              child: Text(
                "Edit Profile",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 19),
              ),
            ),
          ],
        ),
      ),
      // Evita que el teclado desplace el contenido
      resizeToAvoidBottomInset: false,
      // Cuerpo principal de la pantalla
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),// Espaciado superior
            GestureDetector(  // Selector de imagen (Avatar)
              onTap: _pickImage, // Al tocar, ejecuta la función para seleccionar imagen
              child: CircleAvatar(
                radius: 45, // Tamaño del círculo exterior
                backgroundColor: Colors.black, // Color del borde
                child: CircleAvatar(
                  radius: 43, // Tamaño del círculo interior
                  backgroundColor: Colors.white,
                  child:
                   // Muestra la imagen seleccionada, la actual o un ícono por defecto
                      _pickerFile != null
                          ? ClipOval(  // Imagen recién seleccionada
                            child: Image.file(
                              File(_pickerFile!.path),
                              width: 86,
                              height: 86,
                              fit: BoxFit.cover,
                            ),
                          )
                          : _imageUrl != null
                          ? ClipOval( // Imagen actual del perfil
                            child: Image.network(
                              _imageUrl!,
                              width: 86,
                              height: 86,
                              fit: BoxFit.cover,
                            ),
                          )
                          : const Icon(Icons.person, size: 40), // Icono por defecto
                ),
              ),
            ),
            // Espaciado entre componentes
            const SizedBox(height: 50),
            // Formulario de edición
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),  // Margen horizontal
              child: Form(
                key: _formKey,  // Key para manejar el estado del formulario
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Alineación izquierda
                  children: [
                    // Etiqueta del campo de nombre
                    Text("New Name User", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),),
                    SizedBox(height: 15),
                    // Campo de texto para editar el nombre
                    TextFormField(
                      controller: _nameController,
                      // Controlador para manejar el texto
                      decoration: InputDecoration(
                        hintText: 'Enter your full name', // Texto de sugerencia
                        hintStyle: TextStyle(color: Colors.grey[500]), // Estilo del hint
                        border: OutlineInputBorder( // Borde normal
                          borderRadius: BorderRadius.circular(10),
                        ),
                        enabledBorder: OutlineInputBorder( // Borde cuando está habilitado
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder( // Borde con foco
                          borderSide: const BorderSide(
                            color: Color(0xFFE0E0E0),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        filled: true, // Activa relleno de fondo
                        fillColor: Colors.grey[300], // Color de fondo
                      ),
                      // Validador del campo
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name'; // Mensaje de error
                        }
                        return null; // Retorna null si es válido
                      },
                    ),
                    // Espaciado grande antes del botón
                    const SizedBox(height: 50),
                     // Botón para guardar cambios
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,  // Centrado horizontal
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await _saveProfile(); // Guarda el perfil
                            Navigator.pop(
                              context,
                            ); // Regresa a la página anterior
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pink, // Color de fondo
                            foregroundColor: Colors.white,  // Color del texto
                            shape: RoundedRectangleBorder( // Forma redondeada
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text('Save Changes'), // Texto del botón
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
