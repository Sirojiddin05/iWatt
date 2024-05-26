import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/phone_representer.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';

class PhoneEditContainer extends StatelessWidget {
  final String phone;
  final VoidCallback? onTap;
  final bool hasEdit;
  final EdgeInsets margin;
  const PhoneEditContainer({super.key, required this.phone, this.onTap, required this.hasEdit, this.margin = EdgeInsets.zero});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: margin,
          child: WCustomTappableButton(
            onTap: onTap ?? () => Navigator.pop(context),
            rippleColor: context.theme.splashColor,
            borderRadius: BorderRadius.circular(6),
            child: PhoneRepresenter(phone: "+998 $phone", hasEdit: hasEdit),
          ),
        ),
        if (hasEdit) ...{
          Positioned(
            top: 4,
            right: 0,
            child: WScaleAnimation(
              onTap: onTap ?? () => Navigator.pop(context),
              child: SvgPicture.asset(AppIcons.phoneEdit),
            ),
          ),
        },
      ],
    );
  }
}
