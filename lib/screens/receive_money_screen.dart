
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart' as txn;
import '../providers/transaction_provider.dart';

class ReceiveMoneyScreen extends StatefulWidget {
  const ReceiveMoneyScreen({super.key});

  @override
  _ReceiveMoneyScreenState createState() => _ReceiveMoneyScreenState();
}

class _ReceiveMoneyScreenState extends State<ReceiveMoneyScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descriptionController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Receive Money"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: "Description / Payer"),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter a description';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: const InputDecoration(labelText: "Amount (ETB)"),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Please enter an amount';
                  if (double.tryParse(value) == null) return 'Please enter a valid number';
                   if (double.parse(value) <= 0) return 'Amount must be positive';
                  return null;
                },
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final transaction = txn.Transaction(
                      description: _descriptionController.text,
                      amount: double.parse(_amountController.text),
                      type: 'receive',
                      date: DateTime.now(),
                    );
                     Provider.of<TransactionProvider>(context, listen: false)
                        .addTransaction(transaction);
                    Navigator.pop(context);
                  }
                },
                child: const Text("Confirm Receipt"),
              ),
               const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
