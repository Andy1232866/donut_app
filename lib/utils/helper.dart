import 'package:flutter/material.dart';

class ProductDetails {
  static void moreDetails(
      BuildContext context, imageName, donutColor, donutFlavor) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: donutColor[50], borderRadius: BorderRadius.circular(24)),
          height: 500,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  imageName,
                  height: 150,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              const Text(
                "Ingredients",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        );
      },
      isScrollControlled: true,
    );
  }
}
