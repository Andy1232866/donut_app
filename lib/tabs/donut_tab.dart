import 'package:donut_app/utils/donut_tile.dart';
import 'package:flutter/material.dart';

class DonutTab extends StatelessWidget {
  final Function(int) onAdd; // Función para agregar al carrito
  // Lista de donas
  final List donutsOnSale = [
    // [donutFlavor, donutPrice, donutColor, imageName]
    ["Ice Cream", 36, Colors.blue, "lib/images/icecream_donut.png"],
    ["Strawberry", 45, Colors.red, "lib/images/strawberry_donut.png"],
    ["Grape Ape", 84, Colors.purple, "lib/images/grape_donut.png"],
    ["Choco", 95, Colors.brown, "lib/images/chocolate_donut.png"],
    ["Mint", 90, Colors.cyan, "lib/images/mint_donut.png"],
    ["Raspberry", 69, Colors.pink, "lib/images/raspberry_donut.png"],
    ["Vanilla", 50, Colors.yellow, "lib/images/vanilla_donut.png"],
    ["Caramel", 55, Colors.orange, "lib/images/caramel_donut.png"],
  ];

  DonutTab({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return DonutTile(
          donutFlavor: donutsOnSale[index][0],
          donutPrice: donutsOnSale[index][1],
          donutColor: donutsOnSale[index][2],
          imageName: donutsOnSale[index][3],
          onAdd: onAdd,
        ); // Pasamos la función
      },
      //Cuántos elementos
      itemCount: donutsOnSale.length,
    );
  }
}
