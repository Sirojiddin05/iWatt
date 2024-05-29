import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/add_car_bloc/add_car_bloc.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class AddCarBottomButton extends StatefulWidget {
  const AddCarBottomButton({super.key});

  @override
  State<AddCarBottomButton> createState() => _AddCarBottomButtonState();
}

class _AddCarBottomButtonState extends State<AddCarBottomButton> with TickerProviderStateMixin {
  late final AnimationController bottomButtonController;
  @override
  void initState() {
    super.initState();
    bottomButtonController = AnimationController(vsync: this, duration: AppConstants.animationDuration);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddCarBloc, AddCarState>(
      listener: (ctx, state) {
        if (state.currentStep == 0) {
          bottomButtonController.reverse();
        } else if (state.currentStep == 1) {
          bottomButtonController.forward();
        }
      },
      builder: (ctx, state) {
        return SizeTransition(
          sizeFactor: bottomButtonController,
          child: WButton(
            onTap: () {
              FocusManager.instance.primaryFocus?.unfocus();
              if (state.currentStep == 1) {
                context.read<AddCarBloc>().add(SetModel());
              } else if (state.currentStep == 2) {
                if (state.temporaryConnectorTypes.length > 3) {
                  context.showPopUp(
                    context,
                    PopUpStatus.warning,
                    message: LocaleKeys.connector_type_limit.tr(),
                  );
                } else {
                  context.read<AddCarBloc>().add(SetConnectorTypes());
                }
              } else if (state.currentStep == 3) {
                context.read<AddCarBloc>().add(AddCar());
              }
            },
            margin: EdgeInsets.fromLTRB(16, 8, 16, context.padding.bottom + 8),
            text: getButtonText(state.currentStep).tr(),
            isDisabled: isDisabled(state),
            isLoading: state.status.isInProgress,
          ),
        );
      },
    );
  }

  String getButtonText(int currentStep) {
    if (currentStep == 2) {
      return LocaleKeys.further;
    }
    return LocaleKeys.confirm;
  }

  bool isDisabled(AddCarState state) {
    final car = state.car;
    final temporaryModel = state.temporaryModel;
    final temporaryConnectorTypes = state.temporaryConnectorTypes;
    if (state.currentStep == 1) {
      if (car.manufacturer == 0) {
        return car.customModel.isEmpty || car.customManufacturer.isEmpty;
      }
      if (temporaryModel == 0) {
        return car.customModel.isEmpty;
      }
      return temporaryModel == -1;
    }
    if (state.currentStep == 2) {
      return temporaryConnectorTypes.isEmpty;
    }
    if (state.currentStep == 3) {
      final number = car.stateNumber;
      final numberType = MyFunctions.carNumberType(number);
      return (car.stateNumber.isNotEmpty) && numberType == 0;
    }
    return false;
  }
}
