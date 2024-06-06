import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/map/presentation/blocs/map_bloc/map_bloc.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapZoomButtons extends StatelessWidget {
  const MapZoomButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: context.colorScheme.background,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(offset: const Offset(0, 4), blurRadius: 6, color: context.theme.shadowColor),
          BoxShadow(offset: const Offset(0, 1), spreadRadius: 1, color: context.theme.shadowColor),
          BoxShadow(offset: const Offset(0, 0), blurRadius: 0, spreadRadius: 4, color: context.theme.shadowColor),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          WCustomTappableButton(
            onTap: () => context.read<MapBloc>().add(ChangeZoomEvent(CameraUpdate.zoomIn())),
            rippleColor: AppColors.cyprus.withAlpha(20),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppIcons.plus,
                width: 24,
                height: 24,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: AppColors.blueBayoux,
              borderRadius: BorderRadius.circular(1),
            ),
            width: 24,
            height: 1,
          ),
          WCustomTappableButton(
            onTap: () => context.read<MapBloc>().add(ChangeZoomEvent(CameraUpdate.zoomOut())),
            rippleColor: AppColors.cyprus.withAlpha(20),
            borderRadius: const BorderRadius.vertical(bottom: Radius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(AppIcons.minus, width: 24, height: 24),
            ),
          ),
        ],
      ),
    );
  }
}
