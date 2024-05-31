import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/info_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/add_car_bloc/add_car_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_number_textfield.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class AdditionalInformation extends StatefulWidget {
  const AdditionalInformation({super.key});

  @override
  State<AdditionalInformation> createState() => _AdditionalInformationState();
}

class _AdditionalInformationState extends State<AdditionalInformation> {
  late final TextEditingController regionTextEditingController;
  late final TextEditingController numberTextEditingController;
  @override
  void initState() {
    super.initState();
    regionTextEditingController = TextEditingController();
    numberTextEditingController = TextEditingController();
    regionTextEditingController.addListener(() {
      final region = regionTextEditingController.text.replaceAll(' ', '');
      final number = numberTextEditingController.text.replaceAll(' ', '');
      final text = '$region$number';
      context.read<AddCarBloc>().add(SetCarNumber(text));
    });
    numberTextEditingController.addListener(() {
      final region = regionTextEditingController.text.replaceAll(' ', '');
      final number = numberTextEditingController.text.replaceAll(' ', '');
      final text = '$region$number';
      context.read<AddCarBloc>().add(SetCarNumber(text));
    });
  }

  @override
  void dispose() {
    regionTextEditingController.dispose();
    numberTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WKeyboardDismisser(
      child: Column(
        children: [
          const Spacer(),
          Text(
            LocaleKeys.government_number_of_car.tr(),
            style: context.textTheme.headlineSmall?.copyWith(color: AppColors.taxBreak),
          ),
          const SizedBox(height: 8),
          CarNumberField(
            regionTextEditingController: regionTextEditingController,
            numberTextEditingController: numberTextEditingController,
            context: context,
            numberType: 0,
          ),
          const Spacer(),
          InfoContainer(
            infoText: LocaleKeys.if_you_enter_your_car_number_you_will_have_additional_conveniences.tr(),
            title: LocaleKeys.helpful_information.tr(),
          ),
        ],
      ),
    );
  }
}
