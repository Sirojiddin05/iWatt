import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWrapper(
        hasBackButton: true,
        title: 'О нас',
        subtitle: 'Version 1.0.0',
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 64, 16, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(AppImages.logo, width: context.sizeOf.width * .5),
            const SizedBox(height: 8),
            Text(
              'c 22.05.2020',
              style: context.textTheme.labelMedium?.copyWith(color: context.textTheme.titleSmall?.color),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: context.appBarTheme.backgroundColor,
              ),
              child: const Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'I-WATT',
                      style: TextStyle(
                        color: Color(0xFF0AE8FE),
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(
                      text: ' - ',
                      style: TextStyle(
                        color: Color(0xFF061018),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    TextSpan(
                      text:
                          'ваш идеальный компаньон для бесперебойной зарядки электромобилей. Разработанное с учетом инноваций и удобства, это приложение революционизирует способ подзарядки вашего электромобиля, делая каждый сеанс зарядки легким и эффективным.',
                      style: TextStyle(
                        color: Color(0xFF061018),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            WCustomTappableButton(
              onTap: () {
                /// todo: rate app
              },
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
                    Text('Оцените приложение', style: context.textTheme.headlineSmall),
                  ],
                ),
              ),
            ),
            const Spacer(),
            Text(
              'Продукт разработан компанией',
              style: context.textTheme.labelMedium?.copyWith(color: context.textTheme.titleSmall?.color),
            ),
            const SizedBox(height: 12),
            Image.asset(
              AppImages.uicLogo,
              width: context.sizeOf.width * .37,
            )
          ],
        ),
      ),
    );
  }
}
