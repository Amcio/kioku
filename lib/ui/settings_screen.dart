import 'package:flutter/material.dart';
import 'package:kioku/data/study_settings_provider.dart';
import 'package:provider/provider.dart';
import '../data/theme_provider.dart';
import '../data/quest_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  final Map<String, Color> allColors = const {
    'Red': Colors.red,
    'Green': Colors.green,
    'Blue': Colors.blue,
    'Yellow': Colors.yellow,
    'Pink': Colors.pink,
    'Orange': Colors.orange,
    'Purple': Colors.purple,
  };

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final questProvider = context.watch<QuestProvider>();
    final studySettingsProvider = context.watch<StudySettingsProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: ListView(
        children: [
          // --- Appearance Section ---
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              "Appearance",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),

          // Theme Mode Selector (Using RadioGroup)
          RadioGroup<ThemeMode>(
            groupValue: themeProvider.themeMode,
            onChanged: (value) {
              if (value != null) {
                themeProvider.setTheme(value);
              }
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
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

          const Divider(),

          // --- Banner Color Section ---
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
            child: Text(
              "Deck Banner Color",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Wrap(
              spacing: 16,
              runSpacing: 16,
              children: allColors.entries.map((entry) {
                final colorName = entry.key;
                final color = entry.value;

                // Check if color is unlocked via QuestProvider
                final isUnlocked = questProvider.isColorUnlocked(colorName);

                // Check if this is the currently selected color
                final isSelected =
                    themeProvider.materialColor.toARGB32() == color.toARGB32();

                return GestureDetector(
                  onTap: isUnlocked
                      ? () => themeProvider.setCustomColor(color)
                      : null, // Disable tap if locked
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: color,
                          border: isSelected
                              ? Border.all(color: Colors.black, width: 4)
                              : null,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            if (isSelected)
                              const BoxShadow(color: Colors.black26, blurRadius: 8),
                          ],
                        ),
                        // Dim the color slightly if it's locked
                        child: !isUnlocked
                            ? Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withValues(alpha: 0.4),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              )
                            : null,
                      ),
                      // Lock Icon
                      if (!isUnlocked)
                        const Icon(Icons.lock, color: Colors.white70, size: 30),
                      // Check Icon
                      if (isSelected)
                        const Icon(Icons.check, color: Colors.white, size: 30),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),

          // Study Screen Settings
          const Divider(),

          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0),
            child: Text(
              "Study Settings",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SwitchListTile(
                  title: const Text("Write Mode"),
                  subtitle: const Text(
                    "EXPERIMENTAL: Write what's on the back of the card",
                  ),
                  value: studySettingsProvider.writeMode,
                  onChanged: (bool value) {
                    studySettingsProvider.setWriteMode(value);
                  },
                  secondary: const Icon(Icons.edit),
                ),
                SwitchListTile(
                  title: const Text("Flip Cards"),
                  subtitle: const Text("Treat backs of flashcards as their fronts."),
                  value: studySettingsProvider.flipAllCards,
                  onChanged: (bool value) {
                    studySettingsProvider.setFlipCards(value);
                  },
                  secondary: const Icon(Icons.flip),
                ),
              ],
            ),
          ),
          // ------------ DEBUG BUTTONS ------------
          const Divider(),
          // Add money
          ListTile(
            leading: const Icon(Icons.bug_report, color: Colors.grey),
            title: const Text("Debug: Add 1000 G"),
            onTap: () {
              context.read<QuestProvider>().debugAddCurrency(1000);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Added 1000 G")));
            },
          ),

          // Reset database
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text("Reset All Data", style: TextStyle(color: Colors.red)),
            onTap: () async {
              // Show confirmation dialog
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text("Factory Reset?"),
                  content: const Text(
                    "Delete all decks, cards, and shop progress. This cannot be undone.",
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text("Cancel"),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(context, true),
                      style: TextButton.styleFrom(foregroundColor: Colors.red),
                      child: const Text("Delete Everything"),
                    ),
                  ],
                ),
              );

              if (confirmed == true && context.mounted) {
                await context.read<QuestProvider>().database.clearAllData();

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("App Reset Complete")),
                  );
                  // Force the Theme/Colors to reset visually if needed
                  context.read<ThemeProvider>().setCustomColor(Colors.red);
                }
              }
            },
          ),

          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
