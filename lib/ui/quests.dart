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
              _buildQuestTile(
                context,
                title: "Log in",
                subtitle: "If you're seeing this, you already did!",
                isDone: data.loginQuestDone,
                isClaimed: data.loginQuestClaimed,
                onClaim: () => provider.claimReward('login'),
              ),
              _buildQuestTile(
                context,
                title: "Learn 5 new words",
                subtitle: "Study new flashcards",
                isDone: data.learnQuestDone,
                isClaimed: data.learnQuestClaimed,
                onClaim: () => provider.claimReward('learn'),
              ),
              _buildQuestTile(
                context,
                title: "Finish daily review",
                subtitle: "Complete all due reviews",
                isDone: data.reviewQuestDone,
                isClaimed: data.reviewQuestClaimed,
                onClaim: () => provider.claimReward('review'),
              ),
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
                    child: const Text('Claim 10 G'),
                  )
                : const SizedBox.shrink(), // Empty if not done
      ),
    );
  }
}