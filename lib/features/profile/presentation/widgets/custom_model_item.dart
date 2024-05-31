import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/features/common/presentation/widgets/clear_field_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/add_car_bloc/add_car_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/model_item.dart';

class CustomModelItem extends StatefulWidget {
  final String title;
  final VoidCallback onTap;
  final int groupValue;
  final int value;
  final String customModel;
  final ValueChanged<String> onChanged;
  const CustomModelItem(
      {super.key,
      required this.title,
      required this.onTap,
      required this.groupValue,
      required this.value,
      required this.customModel,
      required this.onChanged});

  @override
  State<CustomModelItem> createState() => _CustomModelItemState();
}

class _CustomModelItemState extends State<CustomModelItem> with SingleTickerProviderStateMixin {
  late final TextEditingController controller;
  late final ValueNotifier<bool> isClearVisible;
  late final FocusNode focusNode;
  late final AnimationController animationController;
  @override
  void initState() {
    super.initState();
    isClearVisible = ValueNotifier<bool>(false);
    controller = TextEditingController(text: widget.customModel)..addListener(checkVisibilitySuffix);
    focusNode = FocusNode();
    animationController = AnimationController(vsync: this, duration: AppConstants.animationDuration);
    if (widget.value != widget.groupValue) {
      animationController.reverse();
    } else {
      animationController.forward();
    }
  }

  void checkVisibilitySuffix() {
    if (controller.text.isEmpty) {
      isClearVisible.value = false;
    } else if (controller.text.length == 1) {
      isClearVisible.value = true;
    }
  }

  @override
  void didUpdateWidget(covariant CustomModelItem oldWidget) {
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
    controller.removeListener(checkVisibilitySuffix);
    controller.dispose();
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
            child: DefaultTextField(
              controller: controller,
              focusNode: focusNode,
              onChanged: widget.onChanged,
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
                    controller.clear();
                    context.read<AddCarBloc>().add(SetOtherModel(''));
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
