import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/shimmer_loader.dart';
import 'package:i_watt_app/features/list/presentation/widgets/location_data_divider_circle.dart';

class ChargeLocationCardLoader extends StatelessWidget {
  const ChargeLocationCardLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 108,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
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
      child: ShimmerLoading(
        isLoading: true,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const ShimmerContainer(width: 42, height: 42, borderRadius: 90),
                const SizedBox(width: 12),
                ShimmerContainer(height: 40, width: context.sizeOf.width * .6, borderRadius: 4),
              ],
            ),
            const SizedBox(height: 12),
            Container(
              height: 1,
              decoration: BoxDecoration(color: context.theme.dividerColor),
              margin: const EdgeInsets.only(bottom: 8),
            ),
            const Row(
              children: [
                Expanded(
                  child: Row(
                    children: [
                      ShimmerContainer(width: 20, height: 20, borderRadius: 4),
                      SizedBox(width: 2),
                      Expanded(child: ShimmerContainer(width: 20, height: 20, borderRadius: 4)),
                    ],
                  ),
                ),
                LocationDataDividerCircle(),
                Expanded(
                  child: Row(
                    children: [
                      ShimmerContainer(width: 20, height: 20, borderRadius: 4),
                      SizedBox(width: 2),
                      Expanded(child: ShimmerContainer(width: 20, height: 20, borderRadius: 4)),
                    ],
                  ),
                ),
                LocationDataDividerCircle(),
                Expanded(
                  child: Row(
                    children: [
                      ShimmerContainer(width: 20, height: 20, borderRadius: 4),
                      SizedBox(width: 2),
                      Expanded(child: ShimmerContainer(width: 20, height: 20, borderRadius: 4)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
