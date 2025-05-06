import 'package:donut_app/pages/login_page.dart';
import 'package:donut_app/services/signout_service.dart';
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
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                color: Colors.pink,
              ),
            ),
          ),
          ListTile(
            title: Text(
              "Home",
              style: TextStyle(fontSize: 15, color: Colors.green[600]),
            ),
            leading: Icon(Icons.home, color: Colors.green.withOpacity(0.6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              "My Wallet",
              style: TextStyle(fontSize: 15, color: Colors.brown),
            ),
            leading: Icon(
              Icons.wallet_giftcard,
              color: Colors.brown.withOpacity(0.6),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              "Notifications",
              style: TextStyle(fontSize: 15, color: Colors.orange),
            ),
            leading: Icon(
              Icons.notifications,
              color: Colors.orange.withOpacity(0.6),
            ),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              "Favorites",
              style: TextStyle(fontSize: 15, color: Colors.red),
            ),
            leading: Icon(Icons.favorite, color: Colors.red.withOpacity(0.6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Lenguage", style: TextStyle(fontSize: 15)),
            leading: Icon(Icons.chat, color: Colors.black.withOpacity(0.6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              "Rate Us",
              style: TextStyle(fontSize: 15, color: Colors.amber),
            ),
            leading: Icon(Icons.star, color: Colors.amber.withOpacity(0.6)),
            onTap: () {},
          ),
          const Divider(indent: 10, endIndent: 20),
          ListTile(
            title: const Text(
              "Contact Us",
              style: TextStyle(fontSize: 15, color: Colors.teal),
            ),
            leading: Icon(Icons.phone, color: Colors.teal.withOpacity(0.6)),
            onTap: () {},
          ),
          ListTile(
            title: const Text(
              "Share App",
              style: TextStyle(fontSize: 15, color: Colors.purple),
            ),
            leading: Icon(Icons.share, color: Colors.purple.withOpacity(0.6)),
            onTap: () {},
          ),
          const Divider(indent: 10, endIndent: 20),
          ListTile(
            title: const Text(
              "About",
              style: TextStyle(fontSize: 15, color: Colors.blue),
            ),
            leading: Icon(Icons.info, color: Colors.blue.withOpacity(0.6)),
            onTap: () {},
          ),
          const Divider(indent: 10, endIndent: 20),
          ListTile(
            title: const Text(
              'Exit',
              style: TextStyle(fontSize: 15, color: Colors.red),
            ),
            leading: Icon(
              Icons.exit_to_app_outlined,
              color: Colors.red.withOpacity(0.6),
            ),
            onTap: () async {
              SignoutService auth = SignoutService();
              await auth.signOut();

              if (context.mounted) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
