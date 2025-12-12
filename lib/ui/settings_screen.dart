import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/theme_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Appearance",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          // Wrap the tiles in a RadioGroup
          RadioGroup<ThemeMode>(
            groupValue: themeProvider.themeMode,
            onChanged: (value) {
              if (value != null) {
                themeProvider.setTheme(value);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min, // Prevents layout issues in ListView
              children: const [
                // RadioListTile no longer needs groupValue or onChanged
                RadioListTile<ThemeMode>(
                  title: Text("System Default"),
                  value: ThemeMode.system,
                ),
                RadioListTile<ThemeMode>(
                  title: Text("Light Mode"),
                  value: ThemeMode.light,
                ),
                RadioListTile<ThemeMode>(
                  title: Text("Dark Mode"),
                  value: ThemeMode.dark,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}