import 'package:donut_app/utils/pancake_tile.dart';
import 'package:flutter/material.dart';

class PancakeTab extends StatelessWidget {
  final Function(int) onAdd;
  // Lista de pancakes
  final List pancakesOnSale = [
    // [donutFlavor, donutPrice, donutColor, imageName]
    ["Icre Cream", 36, Colors.blue, "lib/images/ice_cream_pancake.png"],
    ["Raspberry", 45, Colors.red, "lib/images/raspberry_pancake.png"],
    ["Grape", 84, Colors.purple, "lib/images/grape_pancake.png"],
    ["Choco", 95, Colors.brown, "lib/images/chocolate_pancake.png"],
    ["Mega Pancake", 90, Colors.cyan, "lib/images/mega_pancake.png"],
    ["Cherry", 69, Colors.pink, "lib/images/cherry_pancake.png"],
    ["Vanilla", 50, Colors.yellow, "lib/images/vanilla_pancake.png"],
    ["Marshmallow", 55, Colors.orange, "lib/images/marshmallow_pancake.png"],
  ];

  PancakeTab({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return PancakeTile(
          pancakeFlavor: pancakesOnSale[index][0],
          pancakePrice: pancakesOnSale[index][1],
          pancakeColor: pancakesOnSale[index][2],
          imageName: pancakesOnSale[index][3],
          onAdd: onAdd,
        );
      },
      //Cuántos elementos
      itemCount: pancakesOnSale.length,
    );
  }
}
