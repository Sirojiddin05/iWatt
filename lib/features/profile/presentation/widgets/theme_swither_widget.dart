import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/features/common/presentation/blocs/theme_switcher_bloc/theme_switcher_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/theme_mode_container.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/white_wrapper_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ThemeSwitcherWidget extends StatefulWidget {
  const ThemeSwitcherWidget({super.key});

  @override
  State<ThemeSwitcherWidget> createState() => _ThemeSwitcherWidgetState();
}

class _ThemeSwitcherWidgetState extends State<ThemeSwitcherWidget> {
  final List<ThemeMode> themes = [
    ThemeMode.light,
    ThemeMode.dark,
    ThemeMode.system,
  ];
  final List<String> themeTitles = [
    LocaleKeys.light,
    LocaleKeys.dark,
    LocaleKeys.system,
  ];
  final List<String> themeImages = [
    AppImages.lightTheme,
    AppImages.darkTheme,
    AppImages.systemTheme,
  ];
  @override
  Widget build(BuildContext context) {
    return WhiteWrapperContainer(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(AppIcons.themeMode),
              const SizedBox(width: 8),
              Text(
                LocaleKeys.app_mode.tr(),
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocBuilder<ThemeSwitcherBloc, ThemeSwitcherState>(
            builder: (context, state) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  themes.length,
                  (index) => ThemeModeContainer(
                    value: themes[index],
                    groupValue: state.selectedThemeMode,
                    title: themeTitles[index],
                    image: themeImages[index],
                    onChanged: (mode) {
                      context.read<ThemeSwitcherBloc>().add(
                            SwitchThemeModeEvent(mode),
                          );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
