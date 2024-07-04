import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/contacts_card_row.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/location_single_card_wrapper.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactsCard extends StatelessWidget {
  final String email;
  final String phone;
  final String website;
  final List<IdNameEntity> socialMedia;
  const ContactsCard({
    super.key,
    required this.email,
    required this.phone,
    required this.website,
    required this.socialMedia,
  });

  @override
  Widget build(BuildContext context) {
    return LocationSingleCardWrapper(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.contacts.tr(),
            style: context.textTheme.headlineLarge,
          ),
          const SizedBox(height: 8),
          if (phone.isNotEmpty) ...{
            ContactsCardRow(
              icon: AppIcons.phoneFill,
              value: phone,
              hint: LocaleKeys.show_phone_number.tr(),
              onTap: () {
                launchUrlString(
                  'tel:$phone',
                  mode: LaunchMode.externalApplication,
                );
              },
            ),
            const SizedBox(height: 16),
          },
          if (website.isNotEmpty) ...{
            ContactsCardRow(
              icon: AppIcons.globe,
              value: website,
              hint: LocaleKeys.show_web_address.tr(),
              onTap: () async {
                await Clipboard.setData(ClipboardData(text: website));
                context.showPopUp(
                  context,
                  PopUpStatus.success,
                  message: LocaleKeys.copied_to_clipboard.tr(),
                );
              },
            ),
            const SizedBox(height: 16),
          },
          if (email.isNotEmpty) ...{
            ContactsCardRow(
              icon: AppIcons.sms,
              value: email,
              hint: LocaleKeys.show_web_address.tr(),
              onTap: () {
                launchUrlString(
                  "mailto:$email",
                  mode: LaunchMode.externalApplication,
                );
              },
            ),
          },
          if (socialMedia.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Divider(color: AppColors.aliceBlue, height: 1),
            const SizedBox(height: 16),
            Wrap(
              spacing: 8,
              runSpacing: 12,
              children: List.generate(
                socialMedia.length,
                (index) => WScaleAnimation(
                  onTap: () {
                    launchUrlString(socialMedia[index].name, mode: LaunchMode.externalApplication);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.solitude,
                    ),
                    child: SvgPicture.network(
                      socialMedia[index].icon,
                      width: 20,
                      height: 20,
                    ),
                  ),
                ),
              ),
            ),
          ]
        ],
      ),
    );
  }
}
