import 'package:flutter/material.dart';

class DrawerApp extends StatelessWidget {
  const DrawerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      child: ListView(
        padding: const EdgeInsets.only(left: 10),
        children: [
          const SizedBox(height: 15),
          const ListTile(
            title: Text(
              "More Options",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          ListTile(
            title: const Text("Home", style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.home, color: Colors.black.withOpacity(0.6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text("My Wallet", style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.wallet_giftcard_rounded,
                color: Colors.black.withOpacity(0.6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Notifications", style: TextStyle(fontSize: 15)),
            leading:
                Icon(Icons.notifications, color: Colors.black.withOpacity(0.6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Favorites", style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.favorite, color: Colors.black.withOpacity(0.6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Lenguage", style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.chat, color: Colors.black.withOpacity(0.6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Rate Us", style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.star, color: Colors.black.withOpacity(0.6)),
            onTap: () {},
          ),
          const Divider(indent: 10, endIndent: 20),
          ListTile(
            title: const Text("Contact Us", style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.phone, color: Colors.black.withOpacity(0.6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Share App", style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.share, color: Colors.black.withOpacity(0.6)),
            onTap: () {},
          ),
          const Divider(indent: 10, endIndent: 20),
          ListTile(
            title: const Text("About", style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.info, color: Colors.black.withOpacity(0.6)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
