import 'package:flutter/material.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_number_1.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_number_2.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_number_3.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_number_4.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_number_5.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_number_6.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/car_number_7.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/number_not_exist_widget.dart';

class CarNumberSwitcher extends StatelessWidget {
  final int numberType;
  final String number;
  const CarNumberSwitcher({super.key, required this.numberType, required this.number});

  @override
  Widget build(BuildContext context) {
    if (numberType == 1) {
      return CarNumber1(number: number);
    }
    if (numberType == 2) {
      return CarNumber2(number: number);
    }
    if (numberType == 3) {
      return CarNumber3(number: number);
    }
    if (numberType == 4) {
      return CarNumber4(number: number);
    }
    if (numberType == 5) {
      return CarNumber5(number: number);
    }
    if (numberType == 6) {
      return CarNumber6(number: number);
    }
    if (numberType == 7) {
      return CarNumber7(number: number);
    }
    return const NumberNotExistWidget();
  }
}
