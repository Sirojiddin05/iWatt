import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/config/storage_keys.dart';
import 'package:i_watt_app/core/services/storage_repository.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/domain/usecases/change_language_usecase.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_radio.dart';
import 'package:i_watt_app/features/profile/data/repositories_impl/change_language_repository_impl.dart';
import 'package:i_watt_app/features/profile/domain/entities/language_entity.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/change_language_bloc/change_language_bloc.dart';
import 'package:i_watt_app/service_locator.dart';

class LanguageBottomSheet extends StatefulWidget {
  final VoidCallback? onConfirm;

  const LanguageBottomSheet({
    this.onConfirm,
    super.key,
  });

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  late LanguageEntity language;
  late final ChangeLanguageBloc changeLanguageBloc;

  @override
  void initState() {
    super.initState();
    language = AppConstants.languageList.firstWhere(
      (element) => element.locale.languageCode == StorageRepository.getString(StorageKeys.language, defValue: 'ru'),
    );
    changeLanguageBloc = ChangeLanguageBloc(ChangeLanguageUseCase(serviceLocator<ChangeLanguageRepositoryImpl>()));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: changeLanguageBloc,
      child: SheetWrapper(
        color: context.colorScheme.background,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SheetHeaderWidget(title: getSheetTitle()),
            ListView.separated(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) {
                return WCustomTappableButton(
                  onTap: () {
                    setState(() {
                      language = AppConstants.languageList[index];
                    });
                  },
                  borderRadius: BorderRadius.zero,
                  rippleColor: context.theme.primaryColor.withAlpha(30),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AppConstants.languageList[index].icon,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          AppConstants.languageList[index].title,
                          style: context.textTheme.headlineMedium,
                        ),
                        const Spacer(),
                        WRadio(
                          groupValue: AppConstants.languageList[index],
                          value: language,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  indent: 52,
                  color: context.theme.dividerColor,
                  height: 1,
                  thickness: 1,
                );
              },
            ),
            const SizedBox(height: 12),
            BlocConsumer<ChangeLanguageBloc, ChangeLanguageState>(
              listenWhen: (o, n) => o.changeLanguageStatus != n.changeLanguageStatus,
              listener: (context, state) {
                if (state.changeLanguageStatus.isSuccess) {
                  Navigator.pop(context);
                }
              },
              builder: (context, state) {
                return WButton(
                  text: getButtonText(),
                  margin: EdgeInsets.fromLTRB(16, 12, 16, context.padding.bottom + 16),
                  isLoading: state.changeLanguageStatus.isInProgress,
                  onTap: () async {
                    context.read<ChangeLanguageBloc>().add(
                          ChangeLanguage(
                            languageCode: language.locale.languageCode,
                            context: context,
                            // onConfirm: () {
                            //   context.read<NotificationBloc>().add(ReinitializeUseCases());
                            //   if (widget.onConfirm != null) {
                            //     widget.onConfirm!();
                            //   } else {
                            //     Navigator.of(context, rootNavigator: false).pushAndRemoveUntil(fade(page: const HomeScreen()), (route) => true);
                            //   }
                            // },
                          ),
                        );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  String getSheetTitle() {
    if (language.locale.languageCode == 'uz') {
      return "Til";
    }
    if (language.locale.languageCode == 'ru') {
      return "Язык";
    }
    if (language.locale.languageCode == 'en') {
      return "Language";
    }
    return "";
  }

  String getButtonText() {
    if (language.locale.languageCode == 'uz') {
      return "Tasdiqlash";
    }
    if (language.locale.languageCode == 'ru') {
      return "Подтвердить";
    }
    if (language.locale.languageCode == 'en') {
      return "Confirm";
    }
    return "";
  }
}
