import 'package:flutter/material.dart';
import 'home_page.dart';
import 'teste_page.dart';
import 'teorie_page.dart';
import 'abonamente_page.dart';
import 'rezultate_page.dart';
import 'despre_page.dart';
import 'test_materii_page.dart';

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
      initialRoute: '/',
      // Static routes for non-dynamic pages.
      routes: {
        '/': (context) => const MainScreen(),
        '/teste': (context) => const TestePage(),
        '/teorie': (context) => const TeoriePage(),
        '/abonament': (context) => const AbonamentePage(),
        '/rezultate': (context) => const RezultatePage(),
        '/despre': (context) => const DesprePage(),
      },
      // Dynamic route handler for routes like '/teste/<codclasa>'
      onGenerateRoute: (settings) {
        final uri = Uri.parse(settings.name!);

        // Check if the path matches /teste/{codclasa}
        if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'teste') {
          final codclasa = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (context) => TestMateriiPage(codclasa: codclasa),
            settings: settings,
          );
        }
        // Teorie

        if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'teorie') {
          final codclasa = uri.pathSegments[1];
          return MaterialPageRoute(
            builder: (context) => TestMateriiPage(codclasa: codclasa),
            settings: settings,
          );
        }
        // Optionally, return a "Page Not Found" screen for unknown routes.
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: const Text('Page Not Found')),
            body: const Center(child: Text('Page Not Found')),
          ),
          settings: settings,
        );
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void _navigateToPage(BuildContext context, String route) {
    Navigator.pop(context); // Close the drawer
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
              decoration: const BoxDecoration(color: Colors.deepPurple),
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
      body: const HomePage(), // Default page content
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
