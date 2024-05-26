import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/active_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/cupertino_date_picker_sheet.dart';
import 'package:i_watt_app/features/common/presentation/widgets/not_active_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/option_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class DatePickerWidget extends StatefulWidget {
  final ValueChanged<DateTime> onChanged;
  const DatePickerWidget({super.key, required this.onChanged});

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime? selectedDateTime;
  @override
  Widget build(BuildContext context) {
    return OptionContainer(
      title: '${LocaleKeys.birth_date.tr()} *',
      icon: AppIcons.calendar,
      content: Builder(
        builder: (ctx) {
          if (selectedDateTime != null) {
            return ActiveText(text: MyFunctions.getFormattedDate(selectedDateTime!));
          }
          return NotActiveText(
            text: LocaleKeys.dd_mm_yyyy.tr(),
          );
        },
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (ctx) {
            return CupertinoDatePickerSheet(
              onDateTimeChanged: (value) {
                setState(() {
                  selectedDateTime = value;
                });
                widget.onChanged(value);
                Navigator.pop(ctx);
              },
            );
          },
        );
      },
    );
  }
}
