import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_text_field.dart';
import 'package:i_watt_app/features/list/presentation/blocs/charge_locations_bloc/charge_locations_bloc.dart';

class SearchAppBar extends StatelessWidget {
  const SearchAppBar({
    super.key,
    required this.focusNode,
    required this.controller,
  });

  final FocusNode focusNode;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(16, context.padding.top + 16, 16, 16),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 6,
            //TODO: theme
            spreadRadius: 0,
            color: AppColors.black.withOpacity(.2),
          ),
        ],
      ),
      child: SearchField(
        controller: controller,
        onChanged: (v) {
          if (v.length >= 3 || v.isEmpty) {
            context.read<ChargeLocationsBloc>().add(SetSearchPatternEvent(v));
          }
        },
        focusNode: focusNode,
      ),
    );
  }
}
