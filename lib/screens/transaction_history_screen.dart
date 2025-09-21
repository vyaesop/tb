
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/transaction_provider.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionProvider = Provider.of<TransactionProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transaction History"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: transactionProvider.transactions.isEmpty
          ? const Center(child: Text("No transactions yet."))
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: transactionProvider.transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactionProvider.transactions[index];
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
            ),
    );
  }
}
