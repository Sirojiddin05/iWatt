import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_touch_ripple/flutter_touch_ripple.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/search_history_bloc/search_history_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class SearchHistoryWidget extends StatelessWidget {
  final Function(String value) onTap;

  const SearchHistoryWidget({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listenWhen: (previous, next) => previous.authenticationStatus != next.authenticationStatus,
      listener: (context, state) {
        context.read<SearchHistoryBloc>().add(GetSearchHistoryEvent());
      },
      child: BlocBuilder<SearchHistoryBloc, SearchHistoryState>(
        builder: (context, state) {
          if (state.searchHistory.isEmpty) {
            return const SizedBox.shrink();
          }
          final searchHistory = state.searchHistory;
          return Column(
            children: [
              Row(
                children: [
                  const SizedBox(width: 16),
                  Text(
                    LocaleKeys.recent_requests.tr(),
                    style: context.textTheme.headlineLarge,
                  ),
                  const Spacer(),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      showCustomAdaptiveDialog(
                        context,
                        title: LocaleKeys.clear_search_history.tr(),
                        description: LocaleKeys.clear_search_history.tr() + '?',
                        cancelStyle: context.textTheme.headlineLarge?.copyWith(
                          fontSize: 17,
                          color: AppColors.dodgerBlue,
                        ),
                        confirmText: LocaleKeys.clear.tr(),
                        confirmStyle: context.textTheme.titleLarge?.copyWith(
                          fontSize: 17,
                          color: AppColors.amaranth,
                        ),
                        onConfirm: () {
                          context.read<SearchHistoryBloc>().add(DeleteAllSearchHistoryEvent());
                        },
                      );
                    },
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
                      onTap: () => onTap(searchHistory[index].locationName),
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
                              searchHistory[index].locationName,
                              style: context.textTheme.headlineMedium,
                              maxLines: 2,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              showCustomAdaptiveDialog(
                                context,
                                title: LocaleKeys.search_histories.tr(),
                                description: LocaleKeys.delete_single_from_search_history.tr(args: ["\"${searchHistory[index].locationName}\""]),
                                cancelStyle: context.textTheme.headlineLarge?.copyWith(
                                  fontSize: 17,
                                  color: AppColors.dodgerBlue,
                                ),
                                confirmText: LocaleKeys.delete.tr(),
                                confirmStyle: context.textTheme.titleLarge?.copyWith(
                                  fontSize: 17,
                                  color: AppColors.amaranth,
                                ),
                                onConfirm: () {
                                  context.read<SearchHistoryBloc>().add(DeleteSingleSearchHistoryEvent(searchHistory[index].id));
                                },
                              );
                            },
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: SvgPicture.asset(AppIcons.close),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(height: 0, thickness: 1, indent: 16, color: context.theme.dividerColor),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
