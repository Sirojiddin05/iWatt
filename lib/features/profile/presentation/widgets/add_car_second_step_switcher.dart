import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/add_car_bloc/add_car_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/add_car_models_list.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/custom_model_mark_step.dart';

class SecondStepSwitcher extends StatelessWidget {
  const SecondStepSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCarBloc, AddCarState>(
      buildWhen: (o, n) {
        return o.car.manufacturer != n.car.manufacturer;
      },
      builder: (ctx, state) {
        if (state.car.manufacturer == 0) {
          return const CustomModelMarkStep();
        } else {
          return const AddCarModelsList();
        }
      },
    );
  }
}
