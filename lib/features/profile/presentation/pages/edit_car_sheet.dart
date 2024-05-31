import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/option_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/edit_car_bloc/edit_car_bloc.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class EditCarSheet extends StatefulWidget {
  const EditCarSheet({super.key});

  @override
  State<EditCarSheet> createState() => _EditCarSheetState();
}

class _EditCarSheetState extends State<EditCarSheet> {
  late final EditCarBloc editCarBloc;

  @override
  void initState() {
    super.initState();
    editCarBloc = EditCarBloc();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: editCarBloc,
      child: SheetWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SheetHeaderWidget(
              title: LocaleKeys.edit_car.tr(),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  BlocBuilder<EditCarBloc, EditCarState>(
                    buildWhen: (o, n) {
                      final isManufacturerChanged = o.car.manufacturer != n.car.manufacturer;
                      final isCustomManufacturerChanged = o.car.manufacturer != n.car.manufacturer;
                      return isManufacturerChanged || isCustomManufacturerChanged;
                    },
                    builder: (context, state) {
                      return OptionContainer(
                        title: LocaleKeys.brand_capital.tr(),
                        content: Text(
                          state.car.manufacturer,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        icon: AppIcons.chevronDown,
                        onTap: () {
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (ctx) {},
                          // );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  BlocBuilder<EditCarBloc, EditCarState>(
                    buildWhen: (o, n) {
                      final isModelChanged = o.car.model != n.car.model;
                      return isModelChanged;
                    },
                    builder: (context, state) {
                      return OptionContainer(
                        title: LocaleKeys.model_capital.tr(),
                        content: Text(
                          state.car.model,
                          style: context.textTheme.titleLarge?.copyWith(
                            fontSize: 16,
                          ),
                        ),
                        icon: AppIcons.chevronDown,
                        onTap: () {
                          // showModalBottomSheet(
                          //   context: context,
                          //   builder: (ctx) {},
                          // );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            WButton(
              onTap: () {},
              text: LocaleKeys.save.tr(),
              margin: EdgeInsets.fromLTRB(
                16,
                8,
                16,
                context.padding.bottom + 16,
              ),
            )
          ],
        ),
      ),
    );
  }
}
