import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/search_history_bloc/search_history_bloc.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class SearchHistoryWidget extends StatelessWidget {
  const SearchHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
      builder: (context, state) {
        if (state.searchHistory.isEmpty) {
          return const SizedBox.shrink();
        }
        final searchHistory = state.searchHistory;
        return Column(
          children: [
            Row(
              children: [
                Text(
                  LocaleKeys.recent_requests.tr(),
                  style: context.textTheme.headlineLarge,
                ),
                const Spacer(),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
                    child: Text(
                      LocaleKeys.clear.tr(),
                      style: context.textTheme.titleLarge!.copyWith(color: AppColors.amaranth),
                    ),
                  ),
                )
              ],
            ),
            ...List.generate(
              searchHistory.length,
              (index) => Column(
                children: [
                  TouchRipple(
                    onTap: () {},
                    onLongTap: (count) {
                      return true;
                    },
                    rippleColor: AppColors.cyprusRipple30,
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        SvgPicture.asset(AppIcons.historyIcon),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            searchHistory[index].name,
                            style: context.textTheme.headlineMedium,
                            maxLines: 2,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          behavior: HitTestBehavior.opaque,
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: SvgPicture.asset(AppIcons.close),
                          ),
                        )
                      ],
                    ),
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1,
                    indent: 16,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
