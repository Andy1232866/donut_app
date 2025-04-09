import 'package:donut_app/utils/burger_tile.dart';
import 'package:flutter/material.dart';

class BurgerTab extends StatelessWidget {
  final Function(int) onAdd;
  // Lista de hamburguesas
  final List burgersOnSale = [
    // [donutFlavor, donutPrice, donutColor, imageName]
    ["Classic Burger", 36, Colors.blue, "lib/images/classic_burger.png"],
    ["Kid's Burger", 45, Colors.red, "lib/images/kids_burger.png"],
    ["Extra Cheese", 84, Colors.purple, "lib/images/extra_cheese.png"],
    ["Big Burger", 95, Colors.brown, "lib/images/big_burger.png"],
    ["Mushroom Burger", 90, Colors.cyan, "lib/images/mushroom_burger.png"],
    ["Extra Bread", 69, Colors.pink, "lib/images/extra_bread.png"],
    ["Sausage Burger", 50, Colors.yellow, "lib/images/sausage_burger.png"],
    ["Vegan Burger", 55, Colors.orange, "lib/images/vegan_burger.png"],
  ];

  BurgerTab({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return BurgerTile(
            burgerFlavor: burgersOnSale[index][0],
            burgerPrice: burgersOnSale[index][1],
            burgerColor: burgersOnSale[index][2],
            imageName: burgersOnSale[index][3],
            onAdd: onAdd);
      },
      //Cuántos elementos
      itemCount: burgersOnSale.length,
    );
  }
}
