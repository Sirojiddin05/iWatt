import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/text_formatters/formatter.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_close_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/credit_cards_bloc/credit_cards_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/code_verification_bottom_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/supported_cards.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AddCardBottomSheet extends StatefulWidget {
  const AddCardBottomSheet({super.key});

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  final List<Widget> cardIcons = [
    SvgPicture.asset(AppIcons.cardNumber, key: const ValueKey<int>(0)),
    SvgPicture.asset(AppIcons.uzcard, key: const ValueKey<int>(1)),
    SvgPicture.asset(AppIcons.humo, key: const ValueKey<int>(2)),
    SvgPicture.asset(AppIcons.visa, key: const ValueKey<int>(3)),
    SvgPicture.asset(AppIcons.masterCard, key: const ValueKey<int>(4)),
  ];
  late TextEditingController expireDateController;
  late TextEditingController cardCVVController;
  late TextEditingController cardController;
  late TextEditingController cardNameController;
  late ValueNotifier<int> cardIconNotifier;

  @override
  void initState() {
    super.initState();
    expireDateController = TextEditingController();
    cardNameController = TextEditingController()..addListener(cardNumberListener);
    cardCVVController = TextEditingController();
    cardIconNotifier = ValueNotifier<int>(0);
    cardController = TextEditingController()..addListener(cardNumberListener);
  }

  cardNumberListener() {
    if (cardController.text.length == 4) {
      final first4Number = cardController.text.substring(0, 4);
      if (first4Number == "8600") {
        cardIconNotifier.value = 1;
      } else if (first4Number == "9860") {
        cardIconNotifier.value = 2;
      } else {
        cardIconNotifier.value = 0;
      }
    } else if (cardController.text.length == 3) {
      cardIconNotifier.value = 0;
    }
  }

  @override
  void dispose() {
    cardController.dispose();
    expireDateController.dispose();
    cardNameController.dispose();
    cardCVVController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WKeyboardDismisser(
      child: Scaffold(
        backgroundColor: context.theme.appBarTheme.backgroundColor,
        appBar: AppBar(
          elevation: 0,
          leadingWidth: 0,
          automaticallyImplyLeading: false,
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 16),
              Text(LocaleKeys.add_card.tr(), style: context.textTheme.displayMedium),
              const Spacer(),
              SheetCloseButton(
                onTap: () => Navigator.of(context).pop(),
                padding: const EdgeInsets.all(12),
              ),
            ],
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(0),
            child: Divider(height: 0, thickness: 1, color: context.theme.dividerColor),
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Column(
            children: [
              DefaultTextField(
                controller: cardController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  Formatters.cardNumberFormatter,
                ],
                onChanged: (value) {},
                keyboardType: TextInputType.number,
                contentPadding: const EdgeInsets.all(12),
                title: LocaleKeys.card_number.tr(),
                hintText: "0000 0000 0000 0000",
                suffix: ValueListenableBuilder<int>(
                  valueListenable: cardIconNotifier,
                  builder: (BuildContext context, int index, Widget? child) {
                    return Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: cardIcons[index],
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              DefaultTextField(
                controller: expireDateController,
                inputFormatters: [Formatters.cardExpirationDateFormatter],
                onChanged: (value) {},
                keyboardType: TextInputType.number,
                contentPadding: const EdgeInsets.all(12),
                title: LocaleKeys.validity.tr(),
                hintText: LocaleKeys.mm_yy.tr(),
              ),
              const SizedBox(height: 20),
              const SupportedCards()
            ],
          ),
        ),
        bottomNavigationBar: BlocBuilder<CreditCardsBloc, CreditCardsState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextHighlight(
                  text: LocaleKeys.by_clicking_add_you_agree_to_the_privacy_policy.tr(),
                  textAlign: TextAlign.center,
                  textStyle: context.textTheme.labelMedium!.copyWith(color: context.textTheme.titleMedium?.color),
                  words: {
                    (context.locale.languageCode == 'uz'
                        ? "maxfiylik siyosatiga rozilik bildirasiz"
                        : context.locale.languageCode == 'ru'
                            ? "Согласие на политику конфеденциальности"
                            : "agree to the privacy policy"): HighlightedWord(
                      onTap: () {
                        log("termsAndUse");
                      },
                      textStyle: context.textTheme.labelLarge!.copyWith(
                        color: context.theme.primaryColor,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  },
                ),
                BlocListener<CreditCardsBloc, CreditCardsState>(
                  listener: (context, state) {
                    if (state.createCardStatus.isFailure) {
                      context.showPopUp(
                        context,
                        PopUpStatus.failure,
                        message: state.errorMessage,
                      );
                    }
                  },
                  child: WButton(
                    margin: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                    onTap: () async {
                      final expireDate = "${expireDateController.text.substring(3, 5)}${expireDateController.text.substring(0, 2)}";
                      context.read<CreditCardsBloc>().add(
                            CreateCreditCard(
                              onSuccess: () async {
                                await showCupertinoModalBottomSheet(
                                    context: context,
                                    useRootNavigator: true,
                                    builder: (BuildContext context) {
                                      return const CodeVerificationBottomSheet();
                                    }).then((value) {
                                  if (value != null) {
                                    if (value) {
                                      Navigator.pop(context);
                                    }
                                  }
                                });
                              },
                              cardNumber: cardController.text.replaceAll(RegExp(r'\(?\)?-? ?'), ''),
                              expireDate: expireDate,
                            ),
                          );
                    },
                    isLoading: state.createCardStatus.isInProgress,
                    text: LocaleKeys.add.tr(),
                    rippleColor: Colors.white.withAlpha(50),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.locale.languageCode == "ru"
                          ? "При поддержки  "
                          : context.locale.languageCode == "en"
                              ? "Powered by:  "
                              : "",
                      style: context.textTheme.labelMedium!.copyWith(color: AppColors.taxBreak),
                    ),
                    GestureDetector(
                      onTap: () {
                        launchUrlString("https://paylov.uz/", mode: LaunchMode.externalApplication);
                      },
                      child: SvgPicture.asset(AppIcons.paylovIcon),
                    ),
                    context.locale.languageCode == "uz"
                        ? Text(
                            "  tomonidan qo'llab quvvatlanadi.",
                            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.taxBreak),
                          )
                        : const SizedBox(),
                  ],
                ),
                SizedBox(height: context.viewInsets.bottom + context.padding.bottom + 16)
              ],
            );
          },
        ),
      ),
    );
  }
}
