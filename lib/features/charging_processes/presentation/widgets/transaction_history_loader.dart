import 'package:flutter/material.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/transaction_history_card_loader.dart';
import 'package:i_watt_app/features/common/presentation/widgets/shimmer_loader.dart';

class TransactionHistoryLoader extends StatelessWidget {
  const TransactionHistoryLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(10, (index) {
            return const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TransactionHistoryCardLoader(),
                SizedBox(height: 16),
              ],
            );
          }),
        ),
      ),
    );
  }
}
