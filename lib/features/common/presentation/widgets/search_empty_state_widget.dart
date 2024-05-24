import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/info_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/home_tab_controller_provider.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class SearchEmptyStateWidget extends StatefulWidget {
  final bool isForMap;
  const SearchEmptyStateWidget({super.key, required this.isForMap});

  @override
  State<SearchEmptyStateWidget> createState() => _SearchEmptyStateWidgetState();
}

class _SearchEmptyStateWidgetState extends State<SearchEmptyStateWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        EmptyStateWidget(
          icon: AppImages.searchEmpty,
          title: LocaleKeys.nothing_found.tr(),
          subtitle: LocaleKeys.nothing_found_to_your_request.tr(),
        ),
        const Spacer(),
        if (widget.isForMap) ...{
          InfoContainer(infoText: LocaleKeys.you_can_find_the_nearest_charging_station_by_pressing_the_current_button.tr()),
          WButton(
            onTap: () {
              HomeTabControllerProvider.of(context).controller.animateTo(1);
              Navigator.of(context).pop();
            },
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            padding: const EdgeInsets.all(14),
            height: 48,
            text: LocaleKeys.find_station.tr(),
          ),
          SizedBox(height: context.padding.bottom)
        }
      ],
    );
  }
}
