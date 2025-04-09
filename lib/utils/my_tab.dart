import 'package:flutter/material.dart';

class MyTab extends StatelessWidget {
  // Ruta del archivo del icono
  final String iconPath;
  final String tabName;
  const MyTab({super.key, required this.iconPath, required this.tabName});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Tab(
          height: 50,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(16)),
            child: Image.asset(
              iconPath,
              color: Colors.grey[600],
            ),
          ),
        ),
        Text(
          tabName,
          style: const TextStyle(fontSize: 9),
        ),
        const SizedBox(
          height: 5,
        )
      ],
    );
  }
}
