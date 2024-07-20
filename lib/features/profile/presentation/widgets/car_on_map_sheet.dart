import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/util/enums/car_on_map.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/car_on_map_bloc/car_on_map_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_radio_tile.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

void showCarOnMapSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    builder: (ctx) {
      return const CarOnMapSheet();
    },
  );
}

class CarOnMapSheet extends StatelessWidget {
  const CarOnMapSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: context.themedColors.whiteToCyprus,
      ),
      child: SheetWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SheetHeaderWidget(
              title: LocaleKeys.car_on_map.tr(),
            ),
            BlocBuilder<CarOnMapBloc, CarOnMapState>(
              builder: (context, state) {
                return ListView.separated(
                  itemCount: CarOnMap.values.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final carOnMap = CarOnMap.values[index];
                    return WRadioTile(
                      title: carOnMap.title.tr(),
                      value: carOnMap,
                      groupValue: state.carOnMap,
                      icon: Image.asset(carOnMap.icon, width: 54, height: 28),
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      onChanged: (v) {
                        context.read<CarOnMapBloc>().add(CarOnMapChanged(v));
                        Navigator.pop(context);
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(indent: 78, color: context.theme.dividerColor, height: 1, thickness: 1);
                  },
                );
              },
            ),
            SizedBox(height: context.padding.bottom)
          ],
        ),
      ),
    );
  }
}
