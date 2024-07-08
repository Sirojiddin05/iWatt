import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/authentication_status.dart';
import 'package:i_watt_app/core/util/enums/gender.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/common_loader_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/cupertino_date_picker_sheet.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/edit_profile_photo_widget.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/edit_profile_radio_container.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late final TextEditingController fullNameController;
  late final ValueNotifier<String> gender;
  late final ValueNotifier<String> dateOfBirth;
  late final ValueNotifier<String> photo;
  late final ValueNotifier<String> fullName;

  @override
  void initState() {
    super.initState();
    final user = context.read<ProfileBloc>().state.user;
    fullNameController = TextEditingController(text: user.fullName);
    fullName = ValueNotifier(user.fullName);
    gender = ValueNotifier(user.gender);
    dateOfBirth = ValueNotifier(user.dateOfBirth);
    photo = ValueNotifier(user.photo);
  }

  @override
  Widget build(BuildContext context) {
    return WKeyboardDismisser(
      child: Scaffold(
        backgroundColor: context.appBarTheme.backgroundColor,
        appBar: AppBarWrapper(
          title: LocaleKeys.edit_profile.tr(),
          hasBackButton: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Divider(height: 0, thickness: 1, color: context.theme.dividerColor),
          ),
          actions: [
            BlocListener<ProfileBloc, ProfileState>(
              listener: (context, state) {
                if (state.deleteAccountStatus.isSuccess) {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationStatusChanged(authenticationStatus: AuthenticationStatus.unauthenticated));
                  Navigator.pop(context);
                  Navigator.pop(context);
                } else if (state.deleteAccountStatus.isFailure) {
                  context.showPopUp(
                    context,
                    PopUpStatus.failure,
                    message: state.deleteAccountErrorMessage,
                  );
                  Navigator.pop(context);
                } else if (state.deleteAccountStatus.isInProgress) {
                  showCommonLoaderDialog(context);
                }
              },
              child: WScaleAnimation(
                onTap: () {
                  showCustomAdaptiveDialog(
                    context,
                    title: LocaleKeys.delete_account.tr(),
                    description: LocaleKeys.do_you_really_want_to_delete_your_account.tr(),
                    cancelStyle: context.textTheme.headlineLarge?.copyWith(
                      fontSize: 17,
                      color: AppColors.dodgerBlue,
                    ),
                    confirmText: LocaleKeys.delete.tr(),
                    confirmStyle: context.textTheme.titleLarge?.copyWith(
                      fontSize: 17,
                      color: AppColors.amaranth,
                    ),
                    onConfirm: () {
                      context.read<ProfileBloc>().add(DeleteAccount());
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(AppIcons.trash),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16.0),
          child: Column(
            children: [
              ValueListenableBuilder(
                  valueListenable: photo,
                  builder: (context, value, child) {
                    return EditProfilePhotoWidget(
                      photo: value,
                      onChanged: (newValue) {
                        photo.value = newValue;
                        setState(() {});
                      },
                    );
                  }),
              ValueListenableBuilder(
                  valueListenable: photo,
                  builder: (context, value, child) {
                    return AnimatedCrossFade(
                      duration: AppConstants.animationDuration,
                      crossFadeState: value.isEmpty ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                      firstChild: const SizedBox(height: 32, width: double.infinity),
                      secondChild: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: WCustomTappableButton(
                            rippleColor: AppColors.amaranth.withAlpha(30),
                            borderRadius: BorderRadius.circular(8),
                            onTap: () {
                              showCustomAdaptiveDialog(
                                context,
                                title: LocaleKeys.delete_photo.tr(),
                                description: LocaleKeys.do_you_really_want_to_delete_profile_photo.tr(),
                                cancelStyle: context.textTheme.headlineLarge?.copyWith(
                                  fontSize: 17,
                                  color: AppColors.dodgerBlue,
                                ),
                                confirmText: LocaleKeys.delete.tr(),
                                confirmStyle: context.textTheme.titleLarge?.copyWith(
                                  fontSize: 17,
                                  color: AppColors.amaranth,
                                ),
                                onConfirm: () {
                                  photo.value = '';
                                  setState(() {});
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              child: Text(
                                LocaleKeys.delete_photo.tr(),
                                style: context.textTheme.titleSmall?.copyWith(color: AppColors.amaranth),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
              DefaultTextField(
                title: '${LocaleKeys.full_name.tr()} *',
                maxLines: 1,
                textInputAction: TextInputAction.done,
                controller: fullNameController,
                onChanged: (value) {
                  fullName.value = value;
                  setState(() {});
                },
              ),
              // const SizedBox(height: 16),
              // DefaultTextField(
              //   title: '${LocaleKeys.phone_number.tr()} *',
              //   controller: phone,
              //   onChanged: (value) {
              //     setState(() {
              //       _userEntity = _userEntity.copyWith(fullName: value);
              //     });
              //   },
              // ),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  LocaleKeys.birthday.tr(),
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: 12,
                    color: AppColors.darkGray,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              ValueListenableBuilder(
                  valueListenable: dateOfBirth,
                  builder: (context, value, child) {
                    return GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (ctx) {
                            return CupertinoDatePickerSheet(
                              initialDate: DateFormat("yyyy-MM-dd").tryParse(value),
                              onDateTimeChanged: (newValue) {
                                dateOfBirth.value = DateFormat("yyyy-MM-dd").format(newValue);
                                setState(() {});
                                Navigator.pop(ctx);
                              },
                            );
                          },
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: context.theme.dividerColor, width: 1),
                        ),
                        child: Row(
                          children: [
                            Expanded(child: Text(value, style: context.textTheme.bodyMedium)),
                            SvgPicture.asset(AppIcons.calendar),
                          ],
                        ),
                      ),
                    );
                  }),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  LocaleKeys.gender.tr(),
                  style: context.textTheme.titleMedium?.copyWith(
                    fontSize: 12,
                    color: AppColors.darkGray,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              ValueListenableBuilder(
                  valueListenable: gender,
                  builder: (context, value, child) {
                    return EditProfileRadioContainer(
                      label: Gender.male.title.tr(),
                      value: Gender.male,
                      groupValue: Gender.values.firstWhereOrNull(
                        (e) => e.name == value.toLowerCase(),
                      ),
                      onTap: () {
                        if (value.toLowerCase() != Gender.male.name) {
                          gender.value = Gender.male.name.toUpperCase();
                          setState(() {});
                        }
                      },
                    );
                  }),
              const SizedBox(height: 8),
              ValueListenableBuilder(
                  valueListenable: gender,
                  builder: (context, value, child) {
                    return EditProfileRadioContainer(
                      label: Gender.female.title.tr(),
                      value: Gender.female,
                      groupValue: Gender.values.firstWhereOrNull(
                        (e) => e.name == value.toLowerCase(),
                      ),
                      onTap: () {
                        if (value.toLowerCase() != Gender.female.name) {
                          setState(() {
                            gender.value = Gender.female.name.toUpperCase();
                          });
                        }
                      },
                    );
                  }),
            ],
          ),
        ),
        bottomNavigationBar: BlocConsumer<ProfileBloc, ProfileState>(
          listenWhen: (previous, next) => previous.updateProfileStatus != next.updateProfileStatus,
          listener: (context, state) {
            if (state.updateProfileStatus.isSuccess) {
              context.showPopUp(
                context,
                PopUpStatus.success,
                message: LocaleKeys.profile_updated_successfully.tr(),
              );
              Navigator.pop(context);
            } else if (state.updateProfileStatus.isFailure) {
              context.showPopUp(
                context,
                PopUpStatus.failure,
                message: state.updateErrorMessage,
              );
            }
          },
          builder: (context, state) => WButton(
            onTap: () {
              context.read<ProfileBloc>().add(UpdateProfile(
                    fullName: fullName.value,
                    gender: gender.value.toUpperCase(),
                    dateOfBirth: dateOfBirth.value,
                    photo: photo.value,
                  ));
            },
            text: LocaleKeys.save.tr(),
            isDisabled: state.user.fullName == fullName.value &&
                state.user.photo == photo.value &&
                state.user.dateOfBirth == dateOfBirth.value &&
                state.user.gender == gender.value,
            isLoading: state.updateProfileStatus.isInProgress,
            margin: EdgeInsets.fromLTRB(
              16,
              8,
              16,
              context.viewInsets.bottom + context.padding.bottom + 16,
            ),
          ),
        ),
      ),
    );
  }
}
