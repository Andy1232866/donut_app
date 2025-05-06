import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StorageService {
  final SupabaseClient client = Supabase.instance.client; // Creamos una instancia de Supabase

  // Método asíncrono que recibe la imagen seleccionada y el uid del usuario
  Future<String?> uploadPhoto(XFile pickedFile, String userId) async {
    try {
      final fileBytes = await pickedFile.readAsBytes(); // Archivo seleccionado
      final fileName = pickedFile.name; // Nombre de la foto seleccionada

      final path = '$userId/$fileName'; // Ruta de la foto compuesta por el userId y el nombre de la foto

      final response = await client.storage
          .from('photos') // Nombre del bucket de Supabase
          .uploadBinary(
        path,
        fileBytes,
        fileOptions: const FileOptions(upsert: true),
      ); // Subimos la foto a Supabase

      final url = client.storage.from('photos').getPublicUrl(path); // Obtenemos la URL pública de la imagen
      debugPrint('Imagen subida. URL: $url'); // Impresión para conocer la URL
      return url;
    } catch (e) {
      debugPrint('Error al subir la imagen: $e'); // Mensaje de error en caso de que haya uno
      return '';
    }
  }
}
