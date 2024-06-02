import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/features/common/presentation/widgets/clear_field_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/add_car_bloc/add_car_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/model_item.dart';

class CustomModelItemMark extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final int groupValue;
  final int value;
  final String customModel;
  final String customManufacturer;
  final ValueChanged<String> onManufacturerChanged;
  final ValueChanged<String> onModelChanged;

  const CustomModelItemMark({
    super.key,
    required this.title,
    required this.onTap,
    required this.groupValue,
    required this.value,
    required this.customModel,
    required this.customManufacturer,
    required this.onModelChanged,
    required this.onManufacturerChanged,
  });

  @override
  State<CustomModelItemMark> createState() => _CustomModelItemMarkState();
}

class _CustomModelItemMarkState extends State<CustomModelItemMark> with SingleTickerProviderStateMixin {
  late final TextEditingController manufacturerController;
  late final TextEditingController modelController;
  late final ValueNotifier<bool> isClearVisible;
  late final FocusNode focusNode;
  late final AnimationController animationController;

  @override
  void initState() {
    super.initState();
    isClearVisible = ValueNotifier<bool>(false);
    manufacturerController = TextEditingController(text: widget.customManufacturer)..addListener(checkVisibilitySuffix);
    modelController = TextEditingController(text: widget.customModel)..addListener(checkVisibilitySuffixForModel);
    focusNode = FocusNode();
    animationController = AnimationController(vsync: this, duration: AppConstants.animationDuration);
    if (widget.value != widget.groupValue) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  void checkVisibilitySuffix() {
    if (manufacturerController.text.isEmpty) {
      isClearVisible.value = false;
    } else if (manufacturerController.text.length == 1) {
      isClearVisible.value = true;
    }
  }

  void checkVisibilitySuffixForModel() {
    if (modelController.text.isEmpty) {
      isClearVisible.value = false;
    } else if (modelController.text.length == 1) {
      isClearVisible.value = true;
    }
  }

  @override
  void didUpdateWidget(covariant CustomModelItemMark oldWidget) {
    if (widget.value != widget.groupValue) {
      animationController.reverse();
    } else {
      focusNode.requestFocus();
      animationController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    manufacturerController.removeListener(checkVisibilitySuffix);
    manufacturerController.dispose();
    modelController.removeListener(checkVisibilitySuffixForModel);
    modelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ModelItem(
          title: widget.title,
          onTap: widget.onTap,
          groupValue: widget.groupValue,
          value: widget.value,
        ),
        SizeTransition(
          sizeFactor: animationController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                DefaultTextField(
                  controller: manufacturerController,
                  focusNode: focusNode,
                  onChanged: widget.onManufacturerChanged,
                  suffix: ValueListenableBuilder(
                    valueListenable: isClearVisible,
                    builder: (ctx, isVisible, child) {
                      if (isVisible) {
                        return child ?? const SizedBox.shrink();
                      }
                      return const SizedBox.shrink();
                    },
                    child: ClearFieldButton(
                      onClear: () {
                        manufacturerController.clear();
                        context.read<AddCarBloc>().add(SetOtherModel(''));
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                DefaultTextField(
                  controller: modelController,
                  focusNode: focusNode,
                  onChanged: widget.onModelChanged,
                  suffix: ValueListenableBuilder(
                    valueListenable: isClearVisible,
                    builder: (ctx, isVisible, child) {
                      if (isVisible) {
                        return child ?? const SizedBox.shrink();
                      }
                      return const SizedBox.shrink();
                    },
                    child: ClearFieldButton(
                      onClear: () {
                        modelController.clear();
                        context.read<AddCarBloc>().add(SetOtherModel(''));
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
