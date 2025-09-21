
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart' as txn;

class RecentTransactions extends StatelessWidget {
  final List<txn.Transaction> transactions;

  const RecentTransactions({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    if (transactions.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Text("No recent activity."),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: transactions.length > 5 ? 5 : transactions.length,
      itemBuilder: (context, index) {
        final transaction = transactions[index];
        final isSend = transaction.type == 'send';
        return Card(
          color: Theme.of(context).colorScheme.surface,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: isSend ? Colors.red.withOpacity(0.1) : Colors.green.withOpacity(0.1),
              child: Icon(
                isSend ? Icons.arrow_upward : Icons.arrow_downward,
                color: isSend ? Colors.red : Colors.green,
                size: 20,
              ),
            ),
            title: Text(transaction.description, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
            subtitle: Text(DateFormat.yMMMd().add_jm().format(transaction.date)),
            trailing: Text(
              '${isSend ? '-' : '+'} ${NumberFormat.currency(symbol: 'ETB ').format(transaction.amount)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: isSend ? Colors.red : Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        );
      },
    );
  }
}
