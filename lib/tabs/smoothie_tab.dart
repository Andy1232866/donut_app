import 'package:donut_app/utils/smoothie_tile.dart';
import 'package:flutter/material.dart';

class SmoothieTab extends StatelessWidget {
  final Function(int) onAdd;
  // Lista de donas
  final List smoothiesOnSale = [
    // [donutFlavor, donutPrice, donutColor, imageName]
    ["Mango", 36, Colors.blue, "lib/images/mango_smoothie.png"],
    ["Grape", 45, Colors.red, "lib/images/grape_smoothie.png"],
    ["Raspberry", 84, Colors.purple, "lib/images/raspberry_smoothie.png"],
    ["Pear", 95, Colors.brown, "lib/images/pear_smoothie.png"],
    ["Passion", 90, Colors.cyan, "lib/images/passion_smoothie.png"],
    ["Strawberry", 69, Colors.pink, "lib/images/strawberry_smoothie.png"],
    ["Banana", 50, Colors.yellow, "lib/images/banana_smoothie.png"],
    ["Orange", 55, Colors.orange, "lib/images/orange_smoothie.png"],
  ];

  SmoothieTab({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return SmoothieTile(
          smoothieFlavor: smoothiesOnSale[index][0],
          smoothiePrice: smoothiesOnSale[index][1],
          smoothieColor: smoothiesOnSale[index][2],
          imageName: smoothiesOnSale[index][3],
          onAdd: onAdd,
        );
      },
      //Cuántos elementos
      itemCount: smoothiesOnSale.length,
    );
  }
}
