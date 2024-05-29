import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_close_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/profile/domain/entities/car_entity.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/cars_bloc/cars_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/pages/edit_car_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_number_switcher.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/connector_name_widget.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class CarSingleSheet extends StatefulWidget {
  final int carId;

  const CarSingleSheet({required this.carId, super.key});

  @override
  State<CarSingleSheet> createState() => _CarSingleSheetState();
}

class _CarSingleSheetState extends State<CarSingleSheet> {
  late final CarEntity car;
  @override
  void initState() {
    super.initState();
    final state = context.read<CarsBloc>().state;
    car = state.cars.firstWhere((element) => element.id == widget.carId);
  }

  @override
  Widget build(BuildContext context) {
    return SheetWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Align(
            alignment: Alignment.center,
            child: SheetHeadContainer(),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: SheetCloseButton(
              onTap: () => Navigator.pop(context),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.carBigBlue),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: CarNumberSwitcher(
                  numberType: MyFunctions.carNumberType(car.stateNumber),
                  number: car.stateNumber,
                ),
              )
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              MyFunctions.getNameOfCar(car.manufacturerName, car.customManufacturer),
              style: context.textTheme.headlineSmall!.copyWith(fontSize: 16),
            ),
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              MyFunctions.getNameOfCar(car.modelName, car.customModel),
              style: context.textTheme.displayLarge,
            ),
          ),
          const SizedBox(height: 16),
          if (car.chargingTypeName.isNotEmpty) ...{
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                LocaleKeys.connector_types.tr(),
                style: context.textTheme.headlineMedium,
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(
              car.chargingTypeName.length,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 16),
                    SvgPicture.asset(
                      MyFunctions.getChargeTypeIconByStatus(car.chargingTypeName[index]),
                    ),
                    const SizedBox(width: 6),
                    ConnectorTitleWidget(
                      type: car.chargingTypeName[index],
                      isSmall: false,
                    )
                  ],
                ),
              ),
            ),
          },
          const SizedBox(height: 12),
          Divider(height: 1, thickness: 1, color: context.theme.dividerColor),
          WButton(
            text: LocaleKeys.edit.tr(),
            color: AppColors.solitude,
            rippleColor: context.theme.shadowColor,
            textStyle: context.textTheme.headlineLarge!.copyWith(fontSize: 15),
            margin: const EdgeInsets.fromLTRB(16, 20, 16, 8),
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (ctx) {
                  return const EditCarSheet();
                },
              );
            },
          ),
          const SizedBox(height: 12),
          WButton(
            text: LocaleKeys.delete.tr(),
            rippleColor: AppColors.amaranth.withAlpha(30),
            border: Border.all(color: AppColors.amaranth),
            color: context.colorScheme.background,
            textStyle: context.textTheme.headlineLarge!.copyWith(fontSize: 15),
            margin: EdgeInsets.fromLTRB(16, 0, 16, context.padding.bottom + 4),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
