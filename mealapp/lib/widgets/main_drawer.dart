import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.onSelectScreen});

  final void Function(String identifier) onSelectScreen;

  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).primaryColor,
            alignment: Alignment.bottomRight,
            child: const Text(
              'Cooking Up!',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 30,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 20),
          buildListTile(
            'Meals',
            Icons.restaurant,
            () {
              onSelectScreen('meals'); // Update with your route
            },
          ),
          buildListTile(
            'Filters',
            Icons.settings,
            () {
              onSelectScreen('filter'); // Update with your route
            },
          ),
        ],
      ),
    );
  }
}
