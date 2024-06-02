import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/clear_field_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class SearchField extends StatefulWidget {
  final TextEditingController? controller;
  final ValueChanged<String> onChanged;
  final VoidCallback? onClear;
  final FocusNode? focusNode;
  final GlobalKey<FormState>? stateKey;
  final bool focus;
  final double height;
  final double? width;
  final String searchIcon;

  const SearchField({
    this.focusNode,
    this.stateKey,
    this.controller,
    required this.onChanged,
    this.onClear,
    super.key,
    this.focus = false,
    this.height = 40,
    this.width,
    this.searchIcon = AppIcons.chevronLeftGrey,
  });

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _controller;
  late final ValueNotifier<bool> suffixVisibility;

  @override
  void initState() {
    suffixVisibility = ValueNotifier(false);
    _controller = widget.controller ?? TextEditingController();
    _controller.addListener(checkVisibilitySuffix);
    super.initState();
  }

  void checkVisibilitySuffix() {
    if (_controller.text.isEmpty) {
      suffixVisibility.value = false;
    } else if (_controller.text.isNotEmpty) {
      suffixVisibility.value = true;
    }
  }

  @override
  void dispose() {
    _controller.removeListener(checkVisibilitySuffix);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      controller: _controller,
      onChanged: widget.onChanged,
      maxLines: 1,
      hintStyle: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
      focusNode: widget.focusNode,
      height: 44,
      fill: true,
      prefixIcon: WScaleAnimation(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: SvgPicture.asset(widget.searchIcon),
        ),
      ),
      hintText: LocaleKeys.input_for_search.tr(),
      suffix: ValueListenableBuilder<bool>(
        valueListenable: suffixVisibility,
        builder: (context, isVisible, child) {
          return Visibility(
            visible: isVisible,
            child: child ?? const SizedBox.shrink(),
          );
        },
        child: ClearFieldButton(
          onClear: widget.onClear ??
              () {
                _controller.clear();
                widget.onChanged('');
              },
        ),
      ),
    );
  }
}
