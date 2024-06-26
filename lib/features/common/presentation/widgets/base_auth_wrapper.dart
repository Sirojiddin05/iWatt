import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/auth_page_subtitle.dart';
import 'package:i_watt_app/features/common/presentation/widgets/auth_page_title.dart';
import 'package:i_watt_app/features/common/presentation/widgets/chevron_back_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';

class BaseAuthWrapper extends StatelessWidget {
  final List<Widget> bodyWidgets;
  final List<Widget> bottomWidgets;
  final String subtitle;
  final String title;

  const BaseAuthWrapper({
    required this.title,
    required this.subtitle,
    required this.bodyWidgets,
    required this.bottomWidgets,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: context.colorScheme.background,
      ),
      child: WKeyboardDismisser(
        child: Scaffold(
          backgroundColor: context.colorScheme.background,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: context.padding.top),
              const Align(
                alignment: Alignment.centerLeft,
                child: ChevronBackButton(),
              ),
              AuthPageTitle(title: title),
              const SizedBox(height: 8),
              AuthPageSubTitle(subtitle: subtitle),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: bodyWidgets,
                  ),
                ),
              ),
              ...bottomWidgets,
              SizedBox(height: context.padding.bottom)
            ],
          ),
        ),
      ),
    );
  }
}
