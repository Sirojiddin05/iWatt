import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_image.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/pages/edit_profile.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/user_image_placeholder.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UserDataContainer extends StatelessWidget {
  const UserDataContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WCustomTappableButton(
      onTap: () => Navigator.of(context, rootNavigator: true).push(
        MaterialWithModalsPageRoute(
          builder: (ctx) => const EditProfilePage(),
        ),
      ),
      borderRadius: BorderRadius.circular(12),
      rippleColor: AppColors.cyprusRipple30,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.16),
              offset: const Offset(0, 6),
              blurRadius: 24,
            ),
          ],
        ),
        child: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            final user = state.user;
            return Row(
              children: [
                WImage(
                  imageUrl: state.user.photo,
                  fit: BoxFit.fill,
                  width: 48,
                  height: 48,
                  borderRadius: BorderRadius.circular(10),
                  errorWidget: const UserImagePlaceholder(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName.isEmpty ? 'User ${user.id}' : user.fullName,
                        style: context.textTheme.headlineLarge?.copyWith(fontSize: 18),
                      ),
                      const SizedBox(height: 2),
                      if (user.phone.isNotEmpty) ...{
                        Text(
                          user.phone,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontSize: 12,
                            //TODO theme
                            color: AppColors.taxBreak,
                          ),
                        ),
                      }
                    ],
                  ),
                ),
                SvgPicture.asset(
                  AppIcons.chevronRightGrey,
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
