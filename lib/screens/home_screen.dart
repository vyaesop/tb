import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../providers/user_provider.dart';
import '../widgets/service_button.dart';
import '../widgets/wavy_header.dart';
import 'send_money_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.user;
    final balanceFormat = NumberFormat.currency(symbol: 'ETB ');

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            WavyHeader(),
            Transform.translate(
              offset: const Offset(0, -80),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Selam, ${user?.name ?? 'User'}',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                             Text(
                              'Balance (ETB)',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                            ),
                            Text(
                              balanceFormat.format(user?.balance ?? 0),
                              style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                           
                          ],
                        ),
                        Row(
                          children: [
                            IconButton(icon: const Icon(Icons.search, color: Colors.white), onPressed: () {}),
                            IconButton(icon: const Icon(Icons.notifications_none, color: Colors.white), onPressed: () {}),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 20),
                     SizedBox(
                      height: 200, 
                      child: GridView.count(
                        crossAxisCount: 4, 
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        physics: const NeverScrollableScrollPhysics(), 
                        children: [
                          ServiceButton(icon: Icons.send, label: 'Send Money', onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SendMoneyScreen()))),
                          ServiceButton(icon: Icons.account_balance_wallet, label: 'Cash In/Out', onTap: () {}),
                          ServiceButton(icon: Icons.phone_iphone, label: 'Airtime', onTap: () {}),
                          ServiceButton(icon: Icons.payment, label: 'Payment', onTap: () {}),
                          ServiceButton(icon: Icons.business, label: 'Dashen Bank', onTap: () {}),
                          ServiceButton(icon: Icons.account_balance, label: 'CBE', onTap: () {}),
                          ServiceButton(icon: Icons.store, label: 'Merchant', onTap: () {}),
                          ServiceButton(icon: Icons.apps, label: 'Apps', onTap: () {}),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF69C17D),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Buy Airtime',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'via telebirr',
                                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            '10% OFF',
                             style: TextStyle(fontSize: 24, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                     ElevatedButton.icon(
                      icon: const Icon(Icons.qr_code_scanner, color: Colors.white),
                      label: const Text('Scan QR', style: TextStyle(color: Colors.white)),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
