import 'package:donut_app/utils/helper.dart';
import 'package:flutter/material.dart';

class DonutTile extends StatelessWidget {
  final String donutFlavor;
  final int donutPrice;
  final dynamic donutColor;
  final String imageName;
  final Function(int) onAdd; // Parámetro para actualizar el carrito

  //Valor fijo del borde circular
  final double borderRadius = 24;
  const DonutTile({
    super.key,
    required this.donutFlavor,
    required this.donutPrice,
    required this.donutColor,
    required this.imageName,
    required this.onAdd, // Recibe la función para poder actualizar el carrito
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        decoration: BoxDecoration(
            color: donutColor[50],
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
                      color: donutColor[100],
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(borderRadius),
                          topRight: Radius.circular(borderRadius))),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
                  child: Text(
                    '\$$donutPrice',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: donutColor[800]),
                  ),
                )
              ],
            ),

            //Imagen del producto
            GestureDetector(
              onDoubleTap: () {
                ProductDetails.moreDetails(
                    context, imageName, donutColor, donutFlavor);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 5),
                child: Image.asset(imageName),
              ),
            ),

            //Tarea: Texto del sabor del producto con la tienda
            Text(
              donutFlavor,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              "Dunkin's",
              style: TextStyle(
                fontSize: 15,
              ),
            ),

            //Tarea: Iconos de "me encanta" y "agregar"
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Love icon
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.favorite_border_outlined,
                      color: Colors.pink,
                    ),
                  ),
                  // Plus button
                  TextButton(
                    onPressed: () {
                      onAdd(donutPrice); // Llamamos a onAdd con el precio
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
