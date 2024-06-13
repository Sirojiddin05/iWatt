import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/blocs/about_us_bloc/about_us_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/error_state_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:in_app_review/in_app_review.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: context.theme.scaffoldBackgroundColor,
      ),
      child: Scaffold(
        appBar: AppBarWrapper(
          hasBackButton: true,
          title: LocaleKeys.about_us.tr(),
          subtitle: MyFunctions.getCurrentVersionSync().replaceAll('V ', 'Version '),
        ),
        body: BlocBuilder<AboutUsBloc, AboutUsState>(
          builder: (context, state) {
            if (state.getAboutUsStatus.isInitial) {
              context.read<AboutUsBloc>().add(GetAboutUsEvent());
            } else if (state.getAboutUsStatus.isInProgress) {
              return const Center(child: CircularProgressIndicator.adaptive());
            } else if (state.getAboutUsStatus.isSuccess) {
              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 64, 16, 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                      tag: 'mainLogo',
                      child: Image.asset(AppImages.logo, width: context.sizeOf.width * .5),
                    ),
                    const SizedBox(height: 32),
                    BlocBuilder<AboutUsBloc, AboutUsState>(
                      builder: (context, state) {
                        String data = "<p><span id=\"title\">I-WATT</span> - ${state.aboutUs.content.replaceAll("<p>", '')}";
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: context.appBarTheme.backgroundColor,
                          ),
                          child: Html(
                            data: data,
                            style: {
                              "#title": Style(
                                padding: HtmlPaddings.zero,
                                fontSize: FontSize(14),
                                color: context.theme.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                              "p": Style(
                                padding: HtmlPaddings.zero,
                                fontSize: FontSize(14),
                                color: context.textTheme.titleLarge?.color,
                                fontFamily: context.textTheme.titleLarge?.fontFamily,
                                fontWeight: FontWeight.w400,
                              ),
                            },
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    WCustomTappableButton(
                      onTap: _rateApp,
                      borderRadius: BorderRadius.circular(12),
                      rippleColor: (Theme.of(context).textTheme.displayLarge?.color ?? AppColors.cyprus).withOpacity(.15),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: context.appBarTheme.backgroundColor,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(AppIcons.star),
                            const SizedBox(width: 8),
                            Text(LocaleKeys.rate_app.tr(), style: context.textTheme.headlineSmall),
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      LocaleKeys.product_is_developed_by_company.tr(),
                      style: context.textTheme.labelMedium?.copyWith(color: context.textTheme.titleSmall?.color),
                    ),
                    const SizedBox(height: 12),
                    Image.asset(
                      AppImages.uicLogo,
                      width: context.sizeOf.width * .37,
                    )
                  ],
                ),
              );
            } else if (state.getAboutUsStatus.isSuccess) {
              return const Column(
                children: [
                  ErrorStateTextWidget(),
                ],
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  _rateApp() async {
    final InAppReview inAppReview = InAppReview.instance;
    bool available = await inAppReview.isAvailable();
    if (available) {
      inAppReview.requestReview();
    }
  }
}
