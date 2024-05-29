import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/connector_types_list.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/car_brands_repository_impl.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/cars_repository_impl.dart';
import 'package:i_watt_app/features/profile/domain/usecases/add_car_usecase.dart';
import 'package:i_watt_app/features/profile/domain/usecases/get_manufacturers_usecase.dart';
import 'package:i_watt_app/features/profile/domain/usecases/get_models_usecase.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/add_car_bloc/add_car_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/manufacturers_bloc/manufacturers_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/models_bloc/models_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/add_car_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/add_car_manufacturers_list.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/add_car_second_step_switcher.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/add_car_sheet_header.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/additional_information.dart';
import 'package:i_watt_app/service_locator.dart';

class AddCarPresentSheet extends StatefulWidget {
  const AddCarPresentSheet({super.key});

  @override
  State<AddCarPresentSheet> createState() => _AddCarPresentSheetState();
}

class _AddCarPresentSheetState extends State<AddCarPresentSheet> {
  late final AddCarBloc addCarBloc;
  late final PageController pageController;
  late final ManufacturersBloc manufacturersBloc;
  late final ModelsBloc modelsBloc;

  @override
  void initState() {
    super.initState();
    addCarBloc = AddCarBloc(AddCarUseCase(repository: serviceLocator<CarsRepositoryImpl>()));
    manufacturersBloc = ManufacturersBloc(GetManufacturersUseCase(serviceLocator<CarBrandsRepositoryImpl>()));
    modelsBloc = ModelsBloc(GetModelsUseCase(serviceLocator<CarBrandsRepositoryImpl>()));
    pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: addCarBloc,
        ),
        BlocProvider.value(
          value: manufacturersBloc,
        ),
        BlocProvider.value(
          value: modelsBloc,
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AddCarBloc, AddCarState>(
            listenWhen: (o, n) => o.currentStep != n.currentStep,
            listener: (context, state) {
              pageController.animateToPage(state.currentStep, duration: AppConstants.animationDuration, curve: Curves.linear);
            },
          ),
          BlocListener<AddCarBloc, AddCarState>(
            listenWhen: (o, n) => o.status != n.status,
            listener: (context, state) {
              if (state.status.isFailure) {
                context.showPopUp(context, PopUpStatus.failure, message: state.error);
              }
            },
          ),
        ],
        child: WKeyboardDismisser(
          child: Scaffold(
            body: SheetWrapper(
              child: Column(
                children: [
                  const AddCarSheetHeader(),
                  Expanded(
                    child: PageView(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        const AddCarManufacturersList(),
                        const SecondStepSwitcher(),
                        BlocBuilder<AddCarBloc, AddCarState>(
                          buildWhen: (o, n) => o.temporaryConnectorTypes != n.temporaryConnectorTypes,
                          builder: (context, state) {
                            return ConnectorTypesList(
                              defaultSelectedTypes: state.temporaryConnectorTypes,
                              onChanged: (list) {
                                addCarBloc.add(SetTemporaryConnectorTypes(list));
                              },
                            );
                          },
                        ),
                        const AdditionalInformation()
                      ],
                    ),
                  ),
                  const AddCarBottomButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
