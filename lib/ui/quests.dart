import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/quest_provider.dart';

class QuestsTab extends StatelessWidget {
  const QuestsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Quests'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Consumer<QuestProvider>(
              builder: (context, provider, child) {
                final currency = provider.data?.currency ?? 0;
                return Center(
                  child: Text(
                    '$currency G',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.amber,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: Consumer<QuestProvider>(
        builder: (context, provider, child) {
          final data = provider.data;
          if (data == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            padding: const EdgeInsets.all(16.0),
            children: [
              // --- Quests ---
              _buildQuestTile(
                context,
                title: "Log in",
                subtitle: "Good job! Now go study.",
                isDone: data.loginQuestDone,
                isClaimed: data.loginQuestClaimed,
                reward: 10,
                onClaim: () => provider.claimReward('login'),
              ),
              _buildQuestTile(
                context,
                title: "Learn 5 new words",
                subtitle: "Gain new knowledge!",
                isDone: data.learnQuestDone,
                isClaimed: data.learnQuestClaimed,
                reward: 10,
                onClaim: () => provider.claimReward('learn'),
              ),
              _buildQuestTile(
                context,
                title: "Finish daily review",
                subtitle: "Do your due diligence.",
                isDone: data.reviewQuestDone,
                isClaimed: data.reviewQuestClaimed,
                reward: 10,
                onClaim: () => provider.claimReward('review'),
              ),
              _buildQuestTile(
                context,
                title: "Finish all daily quests",
                subtitle: "3 dailies a day keeps the women away.",
                isDone: data.allDailyQuestsDone,
                isClaimed: data.allDailyQuestsClaimed,
                reward: 20,
                onClaim: () => provider.claimReward('dailyDone'),
              ),

              const Divider(height: 40, thickness: 2),

              // --- Gacha Shop ---
              const Text("Color Gacha",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _buildGachaSection(context, provider),
            ],
          );
        },
      ),
    );
  }

  Widget _buildQuestTile(
    BuildContext context, {
    required String title,
    required String subtitle,
    required bool isDone,
    required bool isClaimed,
    required int reward,
    required VoidCallback onClaim,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Icon(
          isDone ? Icons.check_circle : Icons.circle_outlined,
          color: isDone ? Colors.green : Colors.grey,
          size: 32,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: isClaimed
            ? const Text('Claimed', style: TextStyle(color: Colors.grey))
            : isDone
                ? ElevatedButton(
                    onPressed: onClaim,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber,
                      foregroundColor: Colors.black,
                    ),
                    child: Text('Claim $reward G'),
                  )
                : Text(
                  '$reward G',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.amber),
                ),
      ),
    );
  }
  
  Widget _buildGachaSection(BuildContext context, QuestProvider provider) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Left decoration
          Column(children: [
            _miniSquare(Colors.red),
            _miniSquare(Colors.green),
            _miniSquare(Colors.blue),
            _miniSquare(Colors.yellow),
          ]),
          const SizedBox(width: 20),

          // Main Button
          Column(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                onPressed: () {
                  // CHECK 1: Enough Money?
                  if ((provider.data?.currency ?? 0) < 100) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Not enough G! Need 100 G.")),
                    );
                    return;
                  }

                  // CHECK 2: Items available?
                  if (!provider.hasLockedColors) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Suffering from success. Nothing left to roll for...")),
                    );
                    return;
                  }

                  // If checks pass, open the animation dialog
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (_) => const GachaDialog(),
                  );
                },
                child: const Text("Try your luck (100 G)"),
              ),
            ],
          ),

          const SizedBox(width: 20),

          // Right decoration
          Column(children: [
            _miniSquare(Colors.pink),
            _miniSquare(Colors.orange),
            _miniSquare(Colors.purple),
            _miniSquare(Colors.blue),
          ]),
        ],
      ),
    );
  }

  Widget _miniSquare(Color color) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      width: 12,
      height: 12,
      color: color,
    );
  }
}

// --- GACHA DIALOG ---

class GachaDialog extends StatefulWidget {
  const GachaDialog({super.key});

  @override
  State<GachaDialog> createState() => _GachaDialogState();
}

class _GachaDialogState extends State<GachaDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  final List<Color> _possibleColors = [
    Colors.green,
    Colors.blue,
    Colors.yellow,
    Colors.pink,
    Colors.orange,
    Colors.purple
  ];
  Color _frontColor = Colors.red;
  Color _backColor = Colors.blue;
  Color _targetColor = Colors.red;

  bool _isRolling = false;
  String? _resultName;
  bool _showResultText = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCirc,
    );
    _controller.addListener(_onAnimationTick);
  }

  void _onAnimationTick() {
    if (!_isRolling) return;
    final double value = _animation.value;
    final double totalRotations = 6.0;
    final double currentRotation = value * totalRotations;
    final double fraction = currentRotation - currentRotation.truncate();
    final bool isBackVisible = fraction > 0.25 && fraction < 0.75;

    if (value < 0.85) {
      final random = Random();
      if (isBackVisible) {
        _frontColor = _possibleColors[random.nextInt(_possibleColors.length)];
      } else {
        _backColor = _possibleColors[random.nextInt(_possibleColors.length)];
      }
    } else {
      _frontColor = _targetColor;
    }
    setState(() {});
  }

  Future<void> _startRoll() async {
    if (_isRolling) return;

    final provider = context.read<QuestProvider>();
    // Call the transactional method
    final result = await provider.unlockRandomColor(100);

    if (!mounted) return;
    // Edge case: User lost money or unlocked everything while dialog was open
    if (result == null || result == 'ALL') {
      Navigator.pop(context); // Close dialog if something weird happened
      return;
    }

    setState(() {
      _isRolling = true;
      _resultName = result;
      _targetColor = _getColorFromName(result);
    });

    await _controller.forward(from: 0.0);

    setState(() {
      _showResultText = true;
    });
  }

  Color _getColorFromName(String name) {
    switch (name) {
      case 'Green': return Colors.green;
      case 'Blue': return Colors.blue;
      case 'Yellow': return Colors.yellow;
      case 'Pink': return Colors.pink;
      case 'Orange': return Colors.orange;
      case 'Purple': return Colors.purple;
      default: return Colors.grey;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _startRoll,
            child: AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                final angle = _animation.value * 6 * 2 * pi;
                return Transform(
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(angle),
                  alignment: Alignment.center,
                  child: _buildCardSide(angle),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          if (!_isRolling && !_showResultText)
            const Text(
              "Click to roll",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  shadows: [BoxShadow(color: Colors.black, blurRadius: 10)]),
            ),
          if (_showResultText) ...[
            Text(
              "Unlocked $_resultName!",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  shadows: [BoxShadow(color: Colors.black, blurRadius: 10)]),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            )
          ]
        ],
      ),
    );
  }

  Widget _buildCardSide(double angle) {
    final normalizedAngle = angle % (2 * pi);
    final isBackVisible =
        normalizedAngle > (pi / 2) && normalizedAngle < (3 * pi / 2);

    // Determine the icon content based on state
    Widget content;
    if (isBackVisible) {
      // Back side (only visible when spinning)
      content = Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(pi),
        child: const SizedBox.shrink(), 
      );
    } else {
      // Front side
      if (_showResultText) {
        // Finished
        content = const Icon(Icons.check, color: Colors.white, size: 60);
      } else if (_isRolling) {
        // Spinning
        content = const SizedBox.shrink(); 
      } else {
        // Idle
        content = const Icon(Icons.help_outline, color: Colors.white54, size: 60);
      }
    }

    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: isBackVisible ? _backColor : _frontColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white, width: 4),
        boxShadow: const [
          BoxShadow(color: Colors.black45, blurRadius: 15, spreadRadius: 2)
        ],
      ),
      alignment: Alignment.center,
      child: content,
    );
  }
}