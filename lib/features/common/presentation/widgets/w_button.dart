import 'package:flutter/cupertino.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';

class WButton extends StatelessWidget {
  final double? width;
  final double height;
  final String text;
  final Color? color;
  final Color? rippleColor;
  final Color? textColor;
  final TextStyle? textStyle;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final GestureTapCallback onTap;
  final BoxBorder? border;
  final double borderRadius;
  final Widget? child;
  final Widget? loadingWidget;
  final Color? disabledColor;
  final Color? disabledTextColor;
  final bool isDisabled;
  final bool isLoading;
  final double? scaleValue;
  final List<BoxShadow>? shadow;
  const WButton({
    super.key,
    required this.onTap,
    this.text = '',
    this.color,
    this.textColor = AppColors.white,
    this.disabledTextColor = AppColors.geyser,
    this.borderRadius = 8,
    this.disabledColor,
    this.isDisabled = false,
    this.isLoading = false,
    this.width,
    this.height = 48,
    this.margin,
    this.padding,
    this.textStyle,
    this.border,
    this.child,
    this.scaleValue,
    this.shadow,
    this.loadingWidget,
    this.rippleColor,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: isLoading || isDisabled,
      child: Padding(
        padding: margin ?? EdgeInsets.zero,
        child: WCustomTappableButton(
          rippleColor: rippleColor ?? AppColors.white.withAlpha(40),
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: width,
            height: height,
            padding: padding ?? EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isDisabled ? disabledColor ?? context.theme.disabledColor : color ?? context.theme.primaryColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: border,
              boxShadow: shadow,
            ),
            child: isLoading
                ? loadingWidget ?? const Center(child: CupertinoActivityIndicator(color: AppColors.white))
                : AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 200),
                    style: context.textTheme.bodySmall!.copyWith(color: isDisabled ? disabledTextColor : textColor),
                    child: child ??
                        Text(
                          text,
                          style: textStyle,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.fade,
                          maxLines: 1,
                        ),
                  ),
          ),
        ),
      ),
    );
  }
}
