import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/enums/connector_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';

class ConnectorStatusContainer extends StatelessWidget {
  final ConnectorStatus status;
  const ConnectorStatusContainer({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: status.color.withOpacity(.1),
      ),
      child: Text(
        status.title.tr(),
        style: context.textTheme.titleMedium!.copyWith(
          color: status.color,
          fontSize: 12,
        ),
      ),
    );
  }
}
