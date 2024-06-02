import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/cars_repository_impl.dart';
import 'package:i_watt_app/features/profile/domain/usecases/delete_car_usecase.dart';
import 'package:i_watt_app/features/profile/domain/usecases/get_cars_use_case.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/cars_bloc/cars_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/pages/add_car_present_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_item.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_single_sheet.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:i_watt_app/service_locator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class MyCarsPage extends StatefulWidget {
  const MyCarsPage({super.key});

  @override
  State<MyCarsPage> createState() => _MyCarsPageState();
}

class _MyCarsPageState extends State<MyCarsPage> {
  late final CarsBloc carsBloc;

  @override
  void initState() {
    super.initState();
    carsBloc = CarsBloc(
      deleteCarUseCase: DeleteCarUseCase(
        serviceLocator<CarsRepositoryImpl>(),
      ),
      getCarsUseCase: GetCarsUseCase(
        serviceLocator<CarsRepositoryImpl>(),
      ),
    )..add(GetCarsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: carsBloc,
      child: Scaffold(
        appBar: AppBarWrapper(
          title: LocaleKeys.my_cars.tr(),
          hasBackButton: true,
        ),
        body: BlocBuilder<CarsBloc, CarsState>(
          builder: (context, state) {
            if (state.getCarsStatus.isSuccess) {
              if (state.cars.isNotEmpty) {
                return ListView.separated(
                  itemCount: state.cars.length,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
                  itemBuilder: (context, index) {
                    final car = state.cars[index];
                    return CarItem(
                      model: car.model,
                      manufacturer: car.manufacturer,
                      number: car.stateNumber,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          useRootNavigator: true,
                          isScrollControlled: true,
                          builder: (context) {
                            return BlocProvider.value(
                              value: carsBloc,
                              child: CarSingleSheet(carId: car.id),
                            );
                          },
                        );
                      },
                      connectorTypes: car.connectorType,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 12);
                  },
                );
              } else {
                return Center(
                  child: EmptyStateWidget(
                    icon: AppImages.carsEmpty,
                    title: LocaleKeys.you_have_no_cars_yet.tr(),
                    subtitle: LocaleKeys.you_have_not_added_any_cars_yet.tr(),
                  ),
                );
              }
            } else if (state.getCarsStatus.isInProgress) {
              return const Center(
                child: CircularProgressIndicator.adaptive(),
              );
            } else {
              return const SizedBox();
            }
          },
        ),
        bottomNavigationBar: WButton(
          onTap: () {
            //TODO overlay style
            showCupertinoModalBottomSheet(
              context: context,
              isDismissible: false,
              builder: (c) => BlocProvider.value(
                value: carsBloc,
                child: const AddCarPresentSheet(),
              ),
            );
          },
          margin: EdgeInsets.fromLTRB(16, 8, 16, context.padding.bottom),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(AppIcons.circlePlus),
              const SizedBox(width: 4),
              Text(
                LocaleKeys.add_car.tr(),
                style: context.textTheme.bodySmall!.copyWith(
                  color: AppColors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getName(String name, String customName) {
    if (name.isNotEmpty) {
      return name;
    } else {
      return customName;
    }
  }
}
