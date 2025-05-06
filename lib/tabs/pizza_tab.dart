import 'package:donut_app/utils/pizza_tile.dart';
import 'package:flutter/material.dart';

class PizzaTab extends StatelessWidget {
  final Function(int) onAdd;
  // Lista de donas
  final List pizzasOnSale = [
    // [donutFlavor, donutPrice, donutColor, imageName]
    ["Mushroom", 36, Colors.blue, "lib/images/mushroom_pizza.png"],
    ["Extra Cheese", 45, Colors.red, "lib/images/extra_cheese_pizza.png"],
    ["Shrimp", 84, Colors.purple, "lib/images/shrimp_pizza.png"],
    ["Pepperoni", 95, Colors.brown, "lib/images/pepperoni_pizza.png"],
    ["Cheese", 90, Colors.cyan, "lib/images/cheese_pizza.png"],
    ["Classic Pizza", 69, Colors.pink, "lib/images/classic_pizza.png"],
    ["Vegan", 50, Colors.yellow, "lib/images/vegan_pizza.png"],
    ["Sausage", 55, Colors.orange, "lib/images/sausage_pizza.png"],
  ];

  PizzaTab({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1 / 1.5),
      itemBuilder: (context, index) {
        return PizzaTile(
          pizzaFlavor: pizzasOnSale[index][0],
          pizzaPrice: pizzasOnSale[index][1],
          pizzaColor: pizzasOnSale[index][2],
          imageName: pizzasOnSale[index][3],
          onAdd: onAdd,
        );
      },
      //Cuántos elementos
      itemCount: pizzasOnSale.length,
    );
  }
}
