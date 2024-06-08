import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/shimmer_loader.dart';

class TransactionHistoryCardLoader extends StatelessWidget {
  const TransactionHistoryCardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: context.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 4),
            blurRadius: 6,
            spreadRadius: 0,
            color: AppColors.black.withOpacity(.05),
          ),
          BoxShadow(
            offset: const Offset(0, 1),
            blurRadius: 0,
            spreadRadius: 1,
            color: AppColors.black.withOpacity(.05),
          ),
          BoxShadow(
            offset: const Offset(0, 0),
            blurRadius: 0,
            spreadRadius: 1,
            color: AppColors.black.withOpacity(.05),
          ),
        ],
      ),
      child: const ShimmerLoading(
        isLoading: true,
        child: Row(
          children: [
            ShimmerContainer(width: 36, height: 36, borderRadius: 6),
            SizedBox(height: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerContainer(height: 17, width: 154, borderRadius: 4),
                  SizedBox(height: 2),
                  ShimmerContainer(height: 17, width: 154, borderRadius: 4),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShimmerContainer(height: 17, width: 63, borderRadius: 4),
                SizedBox(height: 2),
                ShimmerContainer(height: 20, width: 98, borderRadius: 4),
              ],
            )
          ],
        ),
      ),
    );
  }
}
