import 'package:flutter/material.dart';
import 'home_page.dart';
import 'teste_page.dart';
import 'teorie_page.dart';
import 'abonamente_page.dart';
import 'rezultate_page.dart';
import 'despre_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Drawer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/', // Default page
      routes: {
        '/': (context) => const MainScreen(),
        '/teste': (context) => const TestePage(),
        '/teorie': (context) => const TeoriePage(),
        '/abonament': (context) => const AbonamentePage(),
        '/rezultate': (context) => const RezultatePage(),
        '/despre': (context) => const DesprePage(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _navigateToPage(BuildContext context, String route) {
    Navigator.pop(context); // Close drawer
    Navigator.pushNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Flutter Navigation Drawer")),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.deepPurple,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            _buildDrawerItem(context, Icons.home, 'Home', '/'),
            _buildDrawerItem(context, Icons.school, 'Teste', '/teste'),
            _buildDrawerItem(context, Icons.menu_book, 'Teorie', '/teorie'),
            _buildDrawerItem(context, Icons.subscriptions, 'Abonament', '/abonament'),
            _buildDrawerItem(context, Icons.bar_chart, 'Rezultate', '/rezultate'),
            _buildDrawerItem(context, Icons.info, 'Despre', '/despre'),
          ],
        ),
      ),
      body: const HomePage(), // Default Page
    );
  }

  Widget _buildDrawerItem(BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () => _navigateToPage(context, route),
    );
  }
}
