import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/theme_switcher_bloc/theme_switcher_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_container.dart';

class SearchFilterList extends StatelessWidget {
  const SearchFilterList({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(12, context.padding.top + 16, 12, 0),
      child: BlocBuilder<ThemeSwitcherBloc, ThemeSwitcherState>(
        builder: (context, state) {
          return DecoratedBox(
            decoration: BoxDecoration(
              boxShadow: state.appTheme.isDark
                  ? []
                  : [
                      const BoxShadow(
                        offset: Offset(0, 4),
                        blurRadius: 40,
                        spreadRadius: 0,
                        color: AppColors.white,
                      ),
                    ],
            ),
            child: const SearchFilterContainer(
              padding: EdgeInsets.zero,
            ),
          );
        },
      ),
    );
  }
}
