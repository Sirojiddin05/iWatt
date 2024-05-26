import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:url_launcher/url_launcher_string.dart';

class PhoneNumberContainer extends StatelessWidget {
  final String phoneNumber;
  const PhoneNumberContainer({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12, left: 16, right: 16),
      child: WCustomTappableButton(
        onTap: () => launchUrlString('tel:$phoneNumber'),
        borderRadius: BorderRadius.circular(8),
        rippleColor: AppColors.dodgerBlue.withAlpha(30),
        child: Container(
          padding: const EdgeInsets.fromLTRB(0, 8, 8, 8),
          decoration: BoxDecoration(
            border: Border.all(color: context.theme.dividerColor),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 4,
                height: 24,
                margin: const EdgeInsets.only(right: 8),
                decoration: const BoxDecoration(
                  color: AppColors.dodgerBlue,
                  borderRadius: BorderRadius.only(topRight: Radius.circular(8), bottomRight: Radius.circular(8)),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: context.theme.primaryColor,
                ),
                padding: const EdgeInsets.all(6),
                margin: const EdgeInsets.only(right: 12),
                child: SvgPicture.asset(AppIcons.phone),
              ),
              Expanded(
                child: Text(
                  '+998 92 999 99 99',
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
