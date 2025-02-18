import 'package:donut_app/tabs/burger_tab.dart';
import 'package:donut_app/tabs/donut_tab.dart';
import 'package:donut_app/tabs/pancake_tab.dart';
import 'package:donut_app/tabs/pizza_tab.dart';
import 'package:donut_app/tabs/smoothie_tab.dart';

import 'package:donut_app/utils/my_tab.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Widget> myTabs = [
    // Donut tab
    const MyTab(
      iconPath: 'lib/icons/donut.png',
      tabName: 'Donuts',
    ),
    //Burger tab
    const MyTab(
      iconPath: 'lib/icons/burger.png',
      tabName: 'Burger',
    ),
    // Smoothie tab
    const MyTab(
      iconPath: 'lib/icons/smoothie.png',
      tabName: 'Smothie',
    ),
    // Pancake tab
    const MyTab(
      iconPath: 'lib/icons/pancakes.png',
      tabName: 'Pancake',
    ),
    //Pizza tab
    const MyTab(
      iconPath: 'lib/icons/pizza.png',
      tabName: 'Pizza',
    )
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: Icon(
            Icons.menu,
            color: Colors.grey[800],
          ),
          actions: [
            Padding(
              // Agregamos padding a la derecha
              padding: const EdgeInsets.only(right: 12.0),
              child:
                  IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
            )
          ],
        ),
        body: Column(
          children: [
            // Texto "I want to eat"
            const Padding(
              padding: EdgeInsets.only(left: 24),
              child: Row(
                children: [
                  Text(
                    "I want to ",
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    "Eat",
                    style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline),
                  )
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
                child: TabBarView(children: [
              DonutTab(),
              BurgerTab(),
              const SmoothieTab(),
              const PancakeTab(),
              const PizzaTab()
            ])),

            // Carrito
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 28),
                    child: Column(
                      // Alineado a la izquierda
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "2 Items | \$45",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Delivery Charges Included",
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        )
                      ],
                    ),
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pink,
                      ),
                      child: const Text(
                        "View Cart",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
