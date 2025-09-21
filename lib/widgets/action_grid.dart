
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ActionGrid extends StatelessWidget {
  const ActionGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      children: [
        _buildGridItem(context, Icons.arrow_upward, "Send", () {
          context.push('/send');
        }),
        _buildGridItem(context, Icons.arrow_downward, "Receive", () {
           context.push('/receive');
        }),
        _buildGridItem(context, Icons.receipt_long, "Pay Bill", () {}),
        _buildGridItem(context, Icons.phone_iphone, "Airtime", () {}),
      ],
    );
  }

  Widget _buildGridItem(BuildContext context, IconData icon, String label, VoidCallback onTap) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: colorScheme.secondaryContainer,
            child: Icon(icon, color: colorScheme.onSecondaryContainer),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
