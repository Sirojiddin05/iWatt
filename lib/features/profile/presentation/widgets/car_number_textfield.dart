import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/field_wrapper.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/number_divider.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/number_field.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/region_number_field.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/uz_column.dart';

class CarNumberField extends StatefulWidget {
  final double? width;
  final double fontSize;
  final TextEditingController regionTextEditingController;
  final TextEditingController numberTextEditingController;
  final BuildContext context;
  final int numberType;
  final String carNumber;
  final bool requestFocusInitially;

  const CarNumberField({
    super.key,
    this.carNumber = '',
    this.width,
    this.fontSize = 24,
    required this.regionTextEditingController,
    required this.numberTextEditingController,
    required this.context,
    required this.numberType,
    this.requestFocusInitially = true,
  });

  @override
  _CarNumberFieldState createState() => _CarNumberFieldState();
}

class _CarNumberFieldState extends State<CarNumberField> with AutomaticKeepAliveClientMixin {
  final regionRegexes = AppConstants.regionRegexes;
  final numberRegexes = AppConstants.numberRegexes;

  late final ValueNotifier<int> autoType;
  late final TextEditingController regionController;
  late final TextEditingController numberController;
  late final FocusNode nodeNumber;
  late final FocusNode nodeRegion;

  late String carNumber;
  late double scala;

  double? width;
  double fontSize = 24;
  bool isRegionFilled = false;

  @override
  void initState() {
    super.initState();
    nodeRegion = FocusNode();
    if (widget.requestFocusInitially) {
      nodeRegion.requestFocus();
    }
    nodeNumber = FocusNode();
    autoType = ValueNotifier<int>(widget.numberType - 1);

    regionController = widget.regionTextEditingController;
    numberController = widget.numberTextEditingController;

    scala = 1;

    carNumber = widget.carNumber;

    width = widget.width;

    fontSize = widget.fontSize;

    scala = fontSize / 24;

    regionController.addListener(() {
      final text = regionController.text.toUpperCase().trim();

      if (text.length == 2 && !isRegionFilled) {
        if (mounted) {
          isRegionFilled = true;
          final type = getRegionType(text);
          if (type != null) {
            autoType.value = type;
          }
          if (autoType.value == 0 || autoType.value == 1) {
            nodeNumber.requestFocus();
          }
        }
      } else if (text.length == 1) {
        if (mounted) {
          isRegionFilled = false;
          autoType.value = -1;
        }
      }
    });
    numberController.addListener(() {
      final regionText = regionController.text.trim();
      final numberText = numberController.text.trim();
      final text = regionText + numberText;

      if (mounted && text.length >= 6) {
        final type = getNumberType(text);
        if (type != null) {
          autoType.value = type;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Stack(
      children: [
        ValueListenableBuilder<int>(
          valueListenable: autoType,
          builder: (context, type, otherChild) {
            return FieldWrapper(
              backgroundColor: getBackgroundColor(type),
              scala: scala,
              type: type,
              borderColor: getColor(),
            );
          },
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ValueListenableBuilder<int>(
              valueListenable: autoType,
              builder: (ctx, type, child) {
                return Padding(
                  padding: EdgeInsets.only(top: 3 * scala + 2, bottom: 3 * scala + 2, left: 3 * scala + 2),
                  child: AnimatedSize(
                    duration: const Duration(milliseconds: 200),
                    child: SizedBox(
                      width: (type == 2 || type == 3 || type == 4) ? 248 : 60,
                      child: RegionNumberField(
                        textStyle: TextStyle(
                          fontSize: fontSize * 1.3,
                          fontWeight: FontWeight.w500,
                          color: getColor(),
                          fontFamily: "UZBauto",
                          letterSpacing: 2,
                        ),
                        focusNode: nodeRegion,
                        fieldLength: fieldLength(),
                        cursorColor: getColor(),
                        controller: regionController,
                        backgroundColor: type == 0 || type == 1 ? AppColors.conifer2 : null,
                      ),
                    ),
                  ),
                );
              },
            ),
            ValueListenableBuilder<int>(
              valueListenable: autoType,
              builder: (ctx, type, child) {
                if (type == 6 || type == 5 || type == 0 || type == 1) {
                  return NumberDivider(
                    scala: scala,
                    color: getColor(),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
            const SizedBox(width: 14),
            ValueListenableBuilder<int>(
              valueListenable: autoType,
              builder: (ctx, type, child) {
                return AnimatedSize(
                  duration: const Duration(milliseconds: 200),
                  child: type == 2 || type == 3 || type == 4
                      ? const SizedBox.shrink()
                      : SizedBox(
                          width: 140,
                          child: NumberField(
                            controller: numberController,
                            cursorColor: getColor(),
                            style: TextStyle(
                              fontSize: fontSize * 1.3,
                              fontWeight: FontWeight.w500,
                              color: getColor(),
                              fontFamily: "UZBauto",
                              letterSpacing: 2,
                            ),
                            focusNode: nodeNumber,
                            fieldLength: type != 6 && type != 5 ? 6 : 7,
                          ),
                        ),
                );
              },
            )
          ],
        ),
        Positioned(
          right: 3 * scala + 12,
          bottom: 3 * scala,
          top: 3 * scala,
          child: ValueListenableBuilder<int>(
            valueListenable: autoType,
            builder: (ctx, type, child) {
              return AnimatedCrossFade(
                alignment: Alignment.centerRight,
                firstChild: child ?? const SizedBox.shrink(),
                secondChild: const SizedBox(height: 20),
                crossFadeState: type == 0 || type == 1 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                duration: const Duration(milliseconds: 200),
              );
            },
            child: const UzColumn(),
          ),
        )
      ],
    );
  }

  // TextStyle getStyle(int type) {
  //   return TextStyle(
  //     // height: 1.05,
  //     fontSize: fontSize * 1.3,
  //     fontWeight: FontWeight.w500,
  //     color: getColor(type),
  //     fontFamily: "UZBauto",
  //     letterSpacing: 2,
  //   );
  // }

  int? getRegionType(String carNumber) {
    carNumber = carNumber.replaceAll(" ", "");

    for (int i = 0; i < regionRegexes.length; i++) {
      if (regionRegexes[i].hasMatch(carNumber)) {
        return i;
      }
    }
    return -1;
  }

  int? getNumberType(String carNumber) {
    carNumber = carNumber.replaceAll(" ", "");
    for (int i = 0; i < numberRegexes.length; i++) {
      if (numberRegexes[i].hasMatch(carNumber)) return i;
    }
    return -1;
  }

  Color getBackgroundColor(int type) {
    switch (type) {
      case 0:
      case 1:
        return AppColors.white;
      case 2:
        return AppColors.freeSpeechBlue;
      case 3:
      case 4:
      case 5:
        return AppColors.fruitSalad;
      case 6:
        return AppColors.kournikova;
      default:
        return Colors.white;
    }
  }

  int fieldLength() {
    int length = 6;
    switch (autoType.value) {
      case 0:
        length = 2;
        break;
      case 1:
        length = 2;
        break;
      case 2:
        length = 6;
        break;
      case 3:
        length = 7;
        break;
      case 4:
      case 5:
        length = 9;
        break;
      case 6:
        length = 7;
        break;
      default:
        length = 2;
        break;
    }
    return length;
  }

  Color getColor() {
    switch (autoType.value) {
      case 0:
        return Colors.black87;
      case 1:
        return Colors.black87;
      case 2:
        return Colors.white;
      case 3:
        return Colors.white;
      case 4:
      case 5:
        return Colors.white;
      case 6:
        return Colors.black87;
      default:
        return Colors.black87;
    }
  }

  bool isNumberNeeded() {
    if (autoType.value == 4) {
      return false;
    }
    return true;
  }

  int flexSize() {
    switch (autoType.value) {
      case 0:
      case 1:
        return 4;
      case 2:
      case 3:
      case 4:
      case 5:
        return 4;
      default:
        return 3;
    }
  }

  int getFlex() {
    switch (autoType.value) {
      case 2:
        return 4;
      case 3:
      case 4:
      case 5:
        return 5;
      default:
        return 8;
    }
  }

  @override
  bool get wantKeepAlive => true;
}
