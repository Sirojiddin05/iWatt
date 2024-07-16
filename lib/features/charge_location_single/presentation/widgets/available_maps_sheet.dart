import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:map_launcher/map_launcher.dart';

class AvailableMapsSheet extends StatelessWidget {
  final List<AvailableMap> availableMaps;
  final Coords coordinates;
  final String title;
  final String description;
  const AvailableMapsSheet(
      {super.key,
      required this.availableMaps,
      required this.coordinates,
      required this.title,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        color: context.colorScheme.primaryContainer,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...List.generate(availableMaps.length, (index) {
            final map = availableMaps[index];
            return WCustomTappableButton(
              borderRadius: index == 0
                  ? const BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))
                  : BorderRadius.zero,
              rippleColor: AppColors.primaryRipple30,
              onTap: () {
                Navigator.pop(context);
                map.showDirections(
                  destination: coordinates,
                  destinationTitle: title,
                  directionsMode: DirectionsMode.driving,
                  // origin: Coords(
                  //   StorageRepository.getDouble(StorageKeys.latitude, defValue: 0),
                  //   StorageRepository.getDouble(StorageKeys.longitude, defValue: 0),
                  // ),
                  // waypoints:
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SvgPicture.asset(
                        map.icon,
                        height: 30,
                        width: 30,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Text(
                      map.mapName,
                      style: context.textTheme.displaySmall!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          SizedBox(height: MediaQuery.paddingOf(context).bottom + 16)
        ],
      ),
    );
  }
}
