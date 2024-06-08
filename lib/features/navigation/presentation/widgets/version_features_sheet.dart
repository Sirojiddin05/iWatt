import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/navigation/domain/entity/version_features_entity.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/custom_animation_builder.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/dots_indicator.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class VersionFeaturesSheet extends StatefulWidget {
  final List<VersionFeaturesEntity> list;

  const VersionFeaturesSheet({super.key, required this.list});

  @override
  State<VersionFeaturesSheet> createState() => _VersionFeaturesSheetState();
}

class _VersionFeaturesSheetState extends State<VersionFeaturesSheet> with SingleTickerProviderStateMixin {
  late PageController pageController;
  late ValueNotifier<int> currentPageIndex = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    pageController = PageController()
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: context.theme.appBarTheme.backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * .63,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: context.theme.appBarTheme.backgroundColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
              gradient: const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xff08313E),
                  Color(0xff07141C),
                ],
              ),
            ),
            child: NotificationListener(
              onNotification: (OverscrollIndicatorNotification notification) {
                notification.disallowIndicator();
                return false;
              },
              child: PageView.custom(
                controller: pageController,
                physics: const ClampingScrollPhysics(),
                onPageChanged: (page) => currentPageIndex.value = page,
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) => CustomBuilderAnimation(
                    index: index,
                    pageController: pageController,
                    feature: widget.list[index],
                  ),
                  childCount: widget.list.length,
                ),
                padEnds: true,
              ),
            ),
          ),
          const SizedBox(height: 16),
          DotsIndicator(
            dotColor: AppColors.zircon,
            activeDotColor: AppColors.dodgerBlue,
            length: widget.list.length,
            offset: !pageController.hasClients ? 0 : pageController.page ?? 0,
          ),
          WButton(
            onTap: () {
              if (currentPageIndex.value != (widget.list.length - 1)) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeInOutQuad,
                );
              } else {
                Navigator.pop(context);
              }
            },
            text: LocaleKeys.next.tr(),
            margin: EdgeInsets.fromLTRB(16, 12, 16, context.padding.bottom + 10),
          ),
        ],
      ),
    );
  }
}
