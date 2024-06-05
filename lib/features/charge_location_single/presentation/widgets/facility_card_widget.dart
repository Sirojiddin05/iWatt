import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/facility_title_widget.dart';

class FacilityCardWidget extends StatelessWidget {
  final String icon;
  final String title;
  final List<String> facilities;

  const FacilityCardWidget({super.key, required this.icon, required this.title, required this.facilities});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FacilityTitleWidget(icon: icon, title: title),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: List.generate(
              facilities.length,
              (index) => SizedBox(
                width: (context.sizeOf.width - 44) * .5,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SvgPicture.asset(AppIcons.tick),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        facilities[index],
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: context.textTheme.labelLarge!.copyWith(color: AppColors.cyprus),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
