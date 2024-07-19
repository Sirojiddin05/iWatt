import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/pages/search_page.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_filter_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/home_tab_controller_provider.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SearchFilterContainer extends StatefulWidget {
  final EdgeInsets? padding;
  final bool isForMap;
  final Widget filter;

  const SearchFilterContainer({super.key, this.padding, this.isForMap = false, required this.filter});

  @override
  State<SearchFilterContainer> createState() => _SearchFilterContainerState();
}

class _SearchFilterContainerState extends State<SearchFilterContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.fromLTRB(12, context.padding.top + 16, 12, 4),
      child: SearchFilterWrapper(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: WCustomTappableButton(
                borderRadius: BorderRadius.circular(7),
                rippleColor: context.themedColors.cyprusToWhite.withAlpha(20),
                onTap: () {
                  Navigator.of(
                    context,
                    rootNavigator: true,
                  ).push(
                    MaterialWithModalsPageRoute(
                      builder: (ctx) => HomeTabControllerProvider(
                        controller: HomeTabControllerProvider.of(context).controller,
                        child: SearchPage(isForMap: widget.isForMap),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      SvgPicture.asset(context.themedIcons.plugAlt),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          LocaleKeys.search_stations.tr(),
                          style: context.textTheme.headlineSmall!.copyWith(color: AppColors.blueBayoux),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SvgPicture.asset(AppIcons.search),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: AppColors.blueBayoux),
            width: 0.5,
            height: 24,
          ),
          widget.filter,
        ],
      ),
    );
  }
}
