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
    ),
    //Burger tab
    const MyTab(
      iconPath: 'lib/icons/burger.png',
    ),
    // Smoothie tab
    const MyTab(
      iconPath: 'lib/icons/smoothie.png',
    ),
    // Pancake tab
    const MyTab(
      iconPath: 'lib/icons/pancakes.png',
    ),
    //Pizza tab
    const MyTab(
      iconPath: 'lib/icons/pizza.png',
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
            TabBar(tabs: myTabs),

            // Tab Bar View
            Expanded(
                child: TabBarView(children: [
              DonutTab(),
              BurgerTab(),
              SmoothieTab(),
              PancakeTab(),
              PizzaTab()
            ])),

            // Carrito
          ],
        ),
      ),
    );
  }
}
