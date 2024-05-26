import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';

class PhoneRepresenter extends StatelessWidget {
  final String phone;
  final bool hasEdit;
  const PhoneRepresenter({
    super.key,
    required this.phone,
    this.hasEdit = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 6, hasEdit ? 22 : 12, 6),
      decoration: BoxDecoration(
        //Todo: adapt to theme
        color: AppColors.geyser.withOpacity(0.32),
        borderRadius: BorderRadius.circular(6),
        //Todo: adapt to theme
        border: Border.all(color: AppColors.zircon, width: 0.5),
      ),
      child: Text(
        phone,
        style: Theme.of(context).textTheme.headlineSmall,
      ),
    );
  }
}
