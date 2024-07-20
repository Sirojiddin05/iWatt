import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/shimmer_loader.dart';
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
      rippleColor: context.theme.splashColor,
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
                GestureDetector(
                  onTap: () {
                    if (state.user.photo.contains('https://')) {
                      showGeneralDialog(
                        context: context,
                        pageBuilder:
                            (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
                          return UserImageDialog(
                            imageUrl: state.user.photo,
                            animation: animation,
                          );
                        },
                      );
                    }
                  },
                  behavior: HitTestBehavior.opaque,
                  child: WImage(
                    imageUrl: state.user.photo,
                    fit: BoxFit.cover,
                    width: 48,
                    height: 48,
                    borderRadius: BorderRadius.circular(10),
                    errorWidget: const UserImagePlaceholder(),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state.getUserDataStatus.isInProgress) ...{
                        const Shimmer(
                          child: ShimmerLoading(
                            isLoading: true,
                            child: Column(
                              children: [
                                ShimmerContainer(
                                  width: 100,
                                  height: 16,
                                ),
                                SizedBox(height: 2),
                                ShimmerContainer(
                                  width: 100,
                                  height: 16,
                                ),
                              ],
                            ),
                          ),
                        )
                      } else ...{
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
                              color: context.themedColors.taxBreakToZircon,
                            ),
                          ),
                        }
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

class UserImageDialog extends StatelessWidget {
  final Animation animation;
  final String imageUrl;

  const UserImageDialog({
    super.key,
    required this.imageUrl,
    required this.animation,
  });

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle.dark.copyWith(
        systemNavigationBarColor: Colors.transparent,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            behavior: HitTestBehavior.opaque,
            onTapDown: (details) => Navigator.pop(context),
            onTapUp: (details) => Navigator.pop(context),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                return BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: animation.value * 3,
                    sigmaY: animation.value * 3,
                  ),
                  child: child,
                );
              },
              child: SizedBox(
                height: context.sizeOf.height,
                width: context.sizeOf.height,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: WImage(
              width: context.sizeOf.width / 2,
              height: context.sizeOf.width / 2,
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              borderRadius: BorderRadius.circular(context.sizeOf.width),
              errorWidget: const UserImagePlaceholder(),
            ),
          ),
        ],
      ),
    );
  }
}
