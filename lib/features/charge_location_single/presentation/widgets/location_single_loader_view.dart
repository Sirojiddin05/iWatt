import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_card_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/shimmer_loader.dart';

class LocationSingleLoaderView extends StatelessWidget {
  const LocationSingleLoaderView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Column(
        children: [
          const SizedBox(height: 8),
          LocationSingleCardWrapper(
            child: ShimmerLoading(
              isLoading: true,
              child: Row(
                children: [
                  const ShimmerContainer(width: 36, height: 36),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShimmerContainer(height: 16, width: context.sizeOf.width * .4, borderRadius: 4),
                      const SizedBox(height: 4),
                      ShimmerContainer(height: 12, width: context.sizeOf.width * .3, borderRadius: 4),
                    ],
                  ),
                ],
              ),
            ),
          ),
          LocationSingleCardWrapper(
            padding: const EdgeInsets.fromLTRB(16, 16, 0, 16),
            child: ShimmerLoading(
              isLoading: true,
              child: Column(
                children: List.generate(4, (index) {
                  return Column(
                    children: [
                      if (index != 0) const Divider(height: 21, indent: 42),
                      Row(
                        children: [
                          const ShimmerContainer(width: 36, height: 36),
                          const SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ShimmerContainer(height: 16, width: context.sizeOf.width * .4, borderRadius: 4),
                              const SizedBox(height: 4),
                              ShimmerContainer(height: 12, width: context.sizeOf.width * .3, borderRadius: 4),
                            ],
                          ),
                          const SizedBox(width: 24),
                          const Flexible(child: ShimmerContainer(width: 70, height: 24, borderRadius: 4)),
                          const SizedBox(width: 8),
                          const Flexible(child: ShimmerContainer(width: double.infinity, height: 16, borderRadius: 4)),
                          const SizedBox(width: 16),
                        ],
                      ),
                    ],
                  );
                }),
              ),
            ),
          ),
          LocationSingleCardWrapper(
            child: ShimmerLoading(
              isLoading: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ShimmerContainer(width: 100, height: 19, borderRadius: 4),
                      ShimmerContainer(width: 53, height: 19, borderRadius: 4),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runAlignment: WrapAlignment.start,
                    children: <double>[93, 115, 137, 146, 176, 60, 68, 115, 78]
                        .map((e) => ShimmerContainer(
                              width: e,
                              height: 28,
                              borderRadius: 24,
                            ))
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
          LocationSingleCardWrapper(
            child: ShimmerLoading(
              isLoading: true,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ShimmerContainer(width: 100, height: 19, borderRadius: 4),
                  ...(List.generate(
                    3,
                    (index) => const Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Row(
                        children: [
                          ShimmerContainer(width: 28, height: 28),
                          SizedBox(width: 12),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 24),
                              child: ShimmerContainer(height: 28),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
