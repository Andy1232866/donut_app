import 'package:flutter/material.dart';

class BurgerTile extends StatelessWidget {
  final String burgerFlavor;
  final int burgerPrice;
  final dynamic burgerColor;
  final String imageName;
  final Function(int) onAdd;

  //Valor fijo del borde circular
  final double borderRadius = 24;
  const BurgerTile(
      {super.key,
      required this.burgerFlavor, //variables
      required this.burgerPrice,
      required this.burgerColor,
      required this.imageName,
      required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: burgerColor[50],
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Column(
          children: [
            //Precio
            Row(
              //Alinea el texto a la derecha
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: burgerColor[100],
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Text(
                    '\$$burgerPrice',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: burgerColor[800]),
                  ),
                )
              ],
            ),

            //Imagen del producto
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
              child: Image.asset(imageName),
            ),

            //Tarea: Texto del sabor del producto con la tienda
            Text(
              burgerFlavor,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Angry Angus",
              style: TextStyle(
                fontSize: 15,
              ),
            ),

            //Tarea: Iconos de "me encanta" y "agregar"
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Love icon
                  const Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.black,
                  ),
                  TextButton(
                    onPressed: () {
                      onAdd(burgerPrice);
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          decoration: TextDecoration.underline),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
