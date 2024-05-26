import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/enums/gender.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/active_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/radio_option_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class GenderSelectorWidget extends StatefulWidget {
  final ValueChanged<Gender> onChanged;
  const GenderSelectorWidget({super.key, required this.onChanged});

  @override
  State<GenderSelectorWidget> createState() => _GenderSelectorWidgetState();
}

class _GenderSelectorWidgetState extends State<GenderSelectorWidget> {
  late final ValueNotifier<Gender> genderNotifier;
  @override
  void initState() {
    super.initState();
    genderNotifier = ValueNotifier<Gender>(Gender.male);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          LocaleKeys.your_gender.tr(),
          style: context.textTheme.titleMedium?.copyWith(
            fontSize: 12,
            color: AppColors.darkGray,
          ),
        ),
        const SizedBox(height: 6),
        ...List.generate(
          Gender.values.length,
          (index) => ValueListenableBuilder<Gender>(
            valueListenable: genderNotifier,
            builder: (context, gender, child) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: RadioOptionContainer(
                  value: Gender.values[index],
                  groupValue: gender,
                  onChanged: (val) {
                    genderNotifier.value = val;
                    widget.onChanged(val);
                  },
                  child: child ?? const SizedBox.shrink(),
                ),
              );
            },
            child: ActiveText(text: Gender.values[index].title),
          ),
        )
      ],
    );
  }
}
