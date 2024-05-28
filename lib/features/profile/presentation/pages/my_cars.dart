import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class MyCarsPage extends StatefulWidget {
  const MyCarsPage({super.key});

  @override
  State<MyCarsPage> createState() => _MyCarsPageState();
}

class _MyCarsPageState extends State<MyCarsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWrapper(
        title: LocaleKeys.my_cars.tr(),
        hasBackButton: true,
      ),
      bottomNavigationBar: WButton(
        onTap: () {},
        margin: EdgeInsets.fromLTRB(16, 8, 16, context.padding.bottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(AppIcons.circlePlus),
            const SizedBox(width: 4),
            Text(
              LocaleKeys.add_car.tr(),
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
