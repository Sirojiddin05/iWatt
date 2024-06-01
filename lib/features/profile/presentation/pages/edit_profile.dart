import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/gender.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/cupertino_date_picker_sheet.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
import 'package:i_watt_app/features/profile/domain/entities/user_entity.dart';
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
  UserEntity _userEntity = const UserEntity();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userEntity = context.read<ProfileBloc>().state.user;
    fullName.text = _userEntity.fullName;
    phone.text = _userEntity.phone;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: context.appBarTheme.backgroundColor,
          appBar: AppBarWrapper(
            title: LocaleKeys.edit_profile.tr(),
            hasBackButton: true,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Divider(height: 0, thickness: 1, color: context.theme.dividerColor),
            ),
            actions: [
              WScaleAnimation(
                onTap: () {
                  showCustomAdaptiveDialog(
                    context,
                    title: LocaleKeys.do_you_really_want_to_delete_your_account.tr(),
                    cancelStyle: context.textTheme.headlineLarge?.copyWith(
                      fontSize: 17,
                      color: AppColors.dodgerBlue,
                    ),
                    confirmText: LocaleKeys.delete.tr(),
                    confirmStyle: context.textTheme.titleLarge?.copyWith(
                      fontSize: 17,
                      color: AppColors.amaranth,
                    ),
                    onConfirm: () {},
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(AppIcons.trash),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16.0),
            child: Column(
              children: [
                EditProfilePhotoWidget(
                  photo: _userEntity.photo,
                  onChanged: (value) {
                    setState(() {
                      _userEntity = _userEntity.copyWith(photo: value);
                    });
                  },
                ),
                if (_userEntity.photo.isEmpty)
                  const SizedBox(height: 32)
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 4, bottom: 16),
                    child: WScaleAnimation(
                      onTap: () {
                        showCustomAdaptiveDialog(
                          context,
                          title: LocaleKeys.delete_photo.tr(),
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
                            setState(() {
                              _userEntity = _userEntity.copyWith(photo: '');
                            });
                          },
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
                        child: Text(
                          LocaleKeys.delete_photo.tr(),
                          style: context.textTheme.titleSmall?.copyWith(color: AppColors.amaranth),
                        ),
                      ),
                    ),
                  ),
                DefaultTextField(
                  title: '${LocaleKeys.full_name.tr()} *',
                  maxLines: 1,
                  textInputAction: TextInputAction.done,
                  controller: fullName,
                  onChanged: (value) {
                    setState(() {
                      _userEntity = _userEntity.copyWith(fullName: value);
                    });
                  },
                ),
                const SizedBox(height: 16),
                DefaultTextField(
                  title: '${LocaleKeys.phone_number.tr()} *',
                  controller: phone,
                  onChanged: (value) {
                    setState(() {
                      _userEntity = _userEntity.copyWith(fullName: value);
                    });
                  },
                ),
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
                GestureDetector(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (ctx) {
                        return CupertinoDatePickerSheet(
                          initialDate: DateFormat("yyyy-MM-dd").tryParse(_userEntity.dateOfBirth),
                          onDateTimeChanged: (value) {
                            setState(() {
                              _userEntity = _userEntity.copyWith(dateOfBirth: DateFormat("yyyy-MM-dd").format(value));
                            });
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
                      border: Border.all(color: AppColors.fieldBorderZircon, width: 1),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _userEntity.dateOfBirth,
                            style: context.textTheme.bodyMedium,
                          ),
                        ),
                        SvgPicture.asset(AppIcons.calendar),
                      ],
                    ),
                  ),
                ),
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
                EditProfileRadioContainer(
                  label: Gender.male.title.tr(),
                  value: Gender.male,
                  groupValue: Gender.values.firstWhereOrNull(
                    (e) => e.name == _userEntity.gender.toLowerCase(),
                  ),
                  onTap: () {
                    if (_userEntity.gender.toLowerCase() != Gender.male.name) {
                      setState(() {
                        _userEntity = _userEntity.copyWith(gender: Gender.male.name);
                      });
                    }
                  },
                ),
                const SizedBox(height: 8),
                EditProfileRadioContainer(
                  label: Gender.female.title.tr(),
                  value: Gender.female,
                  groupValue: Gender.values.firstWhereOrNull(
                    (e) => e.name == _userEntity.gender.toLowerCase(),
                  ),
                  onTap: () {
                    if (_userEntity.gender.toLowerCase() != Gender.female.name) {
                      setState(() {
                        _userEntity = _userEntity.copyWith(gender: Gender.female.name);
                      });
                    }
                  },
                ),
                const Spacer(),
                BlocListener<ProfileBloc, ProfileState>(
                  listener: (context, state) {
                    if (state.updateProfileStatus.isSuccess) {
                      context.showPopUp(
                        context,
                        PopUpStatus.success,
                        message: "Your profile updated successfully!",
                      );
                    } else if (state.updateProfileStatus.isFailure) {
                      context.showPopUp(
                        context,
                        PopUpStatus.failure,
                        message: state.updateErrorMessage,
                      );
                    }
                  },
                  child: WButton(
                    onTap: () {
                      context.read<ProfileBloc>().add(UpdateProfile(
                            fullName: _userEntity.fullName,
                            gender: _userEntity.gender,
                            dateOfBirth: _userEntity.dateOfBirth,
                            photo: _userEntity.photo,
                          ));
                    },
                    text: LocaleKeys.save.tr(),
                    isDisabled: _userEntity == state.user,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      },
    );
  }
}
