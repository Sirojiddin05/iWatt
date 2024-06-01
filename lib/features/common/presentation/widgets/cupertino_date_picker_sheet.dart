import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class CupertinoDatePickerSheet extends StatefulWidget {
  final DateTime? initialDate;
  final ValueChanged<DateTime> onDateTimeChanged;

  const CupertinoDatePickerSheet({
    super.key,
    required this.onDateTimeChanged,
    this.initialDate,
  });

  @override
  State<CupertinoDatePickerSheet> createState() => _CupertinoDatePickerSheetState();
}

class _CupertinoDatePickerSheetState extends State<CupertinoDatePickerSheet> {
  late DateTime dateTime;

  @override
  void initState() {
    super.initState();
    dateTime = widget.initialDate ?? getEighteenYearsAgo();
  }

  @override
  Widget build(BuildContext context) {
    return SheetWrapper(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetHeaderWidget(
            title: LocaleKeys.select_date.tr(),
          ),
          SizedBox(
            height: 216,
            child: CupertinoDatePicker(
              maximumYear: getEighteenYearsAgo().year,
              minimumYear: get125YearsAgo().year,
              mode: CupertinoDatePickerMode.date,
              onDateTimeChanged: (DateTime value) => dateTime = value,
              initialDateTime: widget.initialDate ?? getEighteenYearsAgo(),
            ),
          ),
          WButton(
            onTap: () => widget.onDateTimeChanged(dateTime),
            text: LocaleKeys.confirm.tr(),
            margin: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              context.padding.bottom + 16,
            ),
          ),
        ],
      ),
    );
  }

  DateTime getEighteenYearsAgo() {
    DateTime today = DateTime.now();
    DateTime eighteenYearsAgo = DateTime(today.year - 18);
    return eighteenYearsAgo;
  }

  DateTime get125YearsAgo() {
    DateTime today = DateTime.now();
    DateTime eighteenYearsAgo = DateTime(today.year - 125);
    return eighteenYearsAgo;
  }
}
