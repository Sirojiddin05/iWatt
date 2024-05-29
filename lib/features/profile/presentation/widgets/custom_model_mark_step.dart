import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/add_car_bloc/add_car_bloc.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class CustomModelMarkStep extends StatefulWidget {
  const CustomModelMarkStep({super.key});

  @override
  State<CustomModelMarkStep> createState() => _CustomModelMarkStepState();
}

class _CustomModelMarkStepState extends State<CustomModelMarkStep> {
  late final TextEditingController markController;
  late final TextEditingController modelController;

  @override
  void initState() {
    super.initState();
    final state = context.read<AddCarBloc>().state;
    markController = TextEditingController(text: state.car.customManufacturer);
    modelController = TextEditingController(text: state.car.customModel);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: DefaultTextField(
            title: LocaleKeys.car_mark_name.tr(),
            hintText: LocaleKeys.input_mark.tr(),
            controller: markController,
            onChanged: (v) {
              context.read<AddCarBloc>().add(SetCustomManufacturer(v));
            },
            onSubmitted: (String value) {},
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: DefaultTextField(
            title: LocaleKeys.car_model_name.tr(),
            hintText: LocaleKeys.input_model.tr(),
            controller: modelController,
            onChanged: (v) {
              context.read<AddCarBloc>().add(SetCustomModel(v));
            },
            onSubmitted: (String value) {},
          ),
        ),
      ],
    );
  }
}
