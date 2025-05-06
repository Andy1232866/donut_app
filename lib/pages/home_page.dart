import 'package:donut_app/pages/cart_page.dart';
import 'package:donut_app/pages/user_info.dart';
import 'package:donut_app/tabs/burger_tab.dart';
import 'package:donut_app/tabs/donut_tab.dart';
import 'package:donut_app/tabs/pancake_tab.dart';
import 'package:donut_app/tabs/pizza_tab.dart';
import 'package:donut_app/tabs/smoothie_tab.dart';
import 'package:donut_app/utils/drawer.dart';

import 'package:donut_app/utils/my_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int cartItemCount = 0;
  int totalPrice = 0;

  // Método para agregar productos al carrito
  void addToCart(int price) {
    setState(() {
      cartItemCount++;
      totalPrice += price;
    });
  }

  List<Widget> myTabs = [
    // Donut tab
    const MyTab(iconPath: 'lib/icons/donut.png', tabName: 'Donuts'),
    //Burger tab
    const MyTab(iconPath: 'lib/icons/burger.png', tabName: 'Burger'),
    // Smoothie tab
    const MyTab(iconPath: 'lib/icons/smoothie.png', tabName: 'Smoothie'),
    // Pancake tab
    const MyTab(iconPath: 'lib/icons/pancakes.png', tabName: 'Pancake'),
    //Pizza tab
    const MyTab(iconPath: 'lib/icons/pizza.png', tabName: 'Pizza'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        drawer: const DrawerApp(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu, color: Colors.grey[800]),
              );
            },
          ),
          actions: [
            Padding(
              // Agregamos padding a la derecha
              padding: const EdgeInsets.only(right: 12.0),
              child: IconButton(
                onPressed: () {
                  User? user = FirebaseAuth.instance.currentUser;

                  if (user != null && !user.isAnonymous) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UserInformation(),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Para acceder debes iniciar sesión',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        action: SnackBarAction(
                          label: 'Ok',
                          onPressed: () {},
                          textColor: Colors.white,
                        ),
                        backgroundColor: Colors.pink,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        duration: const Duration(seconds: 2),
                      ),
                    );

                    debugPrint('Acceso Denegado');
                  }
                },
                icon: const Icon(Icons.person),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            // Texto "I want to eat"
            const Padding(
              padding: EdgeInsets.only(left: 24, bottom: 5),
              child: Row(
                children: [
                  Text("I want to ", style: TextStyle(fontSize: 24)),
                  Text(
                    "Eat",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),

            // Tab Bar
            TabBar(
              tabs: myTabs,
              //Color del texto seleccionado
              labelColor: Colors.pink,
              //Color del texto no seleccionado
              unselectedLabelColor: Colors.grey,
            ),

            // Tab Bar View
            Expanded(
              child: TabBarView(
                children: [
                  DonutTab(onAdd: addToCart),
                  BurgerTab(onAdd: addToCart),
                  SmoothieTab(onAdd: addToCart),
                  PancakeTab(onAdd: addToCart),
                  PizzaTab(onAdd: addToCart),
                ],
              ),
            ),

            // Carrito
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 28),
                    child: Column(
                      // Alineado a la izquierda
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "$cartItemCount Items | \$$totalPrice",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          "Delivery Charges Included",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CartPage(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                    ),
                    child: const Text(
                      "View Cart",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
