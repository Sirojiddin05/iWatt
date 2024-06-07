import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_close_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/credit_cards_bloc/credit_cards_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/code_verification_bottom_sheet.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddCardBottomSheet extends StatefulWidget {
  const AddCardBottomSheet({super.key});

  @override
  State<AddCardBottomSheet> createState() => _AddCardBottomSheetState();
}

class _AddCardBottomSheetState extends State<AddCardBottomSheet> {
  final cardFormatter = MaskTextInputFormatter(
    mask: '#### #### #### ####',
    filter: {"#": RegExp(r'[0-9]')},
  );

  final validityFormatter = MaskTextInputFormatter(
    mask: '##/##',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );

  final cvvFormatter = MaskTextInputFormatter(
    mask: '###',
    filter: {
      "#": RegExp(r'[0-9]'),
    },
  );
  final List<Widget> cardIcons = [
    SvgPicture.asset(AppIcons.card, color: AppColors.blueBayoux, key: const ValueKey<int>(0)),
    SvgPicture.asset(AppIcons.uzcard, key: const ValueKey<int>(1)),
    SvgPicture.asset(AppIcons.humo, key: const ValueKey<int>(2)),
    SvgPicture.asset(AppIcons.visa, key: const ValueKey<int>(3)),
    SvgPicture.asset(AppIcons.masterCard, key: const ValueKey<int>(4)),
  ];
  late TextEditingController cardValidController;
  late TextEditingController cardCVVController;
  late TextEditingController cardController;
  late TextEditingController cardNameController;

  late ValueNotifier<bool> valueListenable;
  late ValueNotifier<int> valueListenableCardIcon;

  @override
  void initState() {
    cardValidController = TextEditingController();
    cardNameController = TextEditingController();
    cardCVVController = TextEditingController();
    cardController = TextEditingController()..addListener(() {});
    valueListenable = ValueNotifier<bool>(false);
    valueListenableCardIcon = ValueNotifier<int>(0);

    super.initState();
  }

  @override
  void dispose() {
    cardController.dispose();
    cardValidController.dispose();
    cardNameController.dispose();
    cardCVVController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WKeyboardDismisser(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        child: Scaffold(
          backgroundColor: context.theme.appBarTheme.backgroundColor,
          bottomNavigationBar: BlocBuilder<CreditCardsBloc, CreditCardsState>(
            builder: (context, state) {
              return ValueListenableBuilder<bool>(
                  valueListenable: valueListenable..value = MediaQuery.of(context).viewInsets.bottom == 0,
                  builder: (context, value, child) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 100),
                          firstChild: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).viewInsets.bottom,
                              )
                            ],
                          ),
                          secondChild: Column(
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
                                      height: 1.6,
                                    ),
                                  ),
                                },
                              ),
                              const SizedBox(height: 16)
                            ],
                          ),
                          crossFadeState: !value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        ),
                        BlocListener<CreditCardsBloc, CreditCardsState>(
                          listener: (context, state) {
                            if (state.createCardStatus.isFailure) {
                              context.showPopUp(
                                context,
                                PopUpStatus.failure,
                                message: state.errorMessage,
                              );
                            } else if (state.createCardStatus.isSuccess) {
                              final expireDate = "${cardValidController.text.substring(3, 5)}${cardValidController.text.substring(0, 2)}";
                              // await showCupertinoModalBottomSheet(
                              //     context: context,
                              //     useRootNavigator: true,
                              //     builder: (BuildContext context) {
                              //       return CodeVerificationBottomSheet(
                              //         expireDate: expireDate,
                              //         cardNumber: cardController.text.replaceAll(RegExp(r'\(?\)?\-?\ ?'), ''),
                              //       );
                              //     }).then((value) {
                              //   if (value != null) {
                              //     if (value) {
                              //       Navigator.pop(context);
                              //     }
                              //   }
                              // });
                            }
                          },
                          child: WButton(
                            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            onTap: () async {
                              final expireDate = "${cardValidController.text.substring(3, 5)}${cardValidController.text.substring(0, 2)}";
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
                                      cardNumber: cardController.text.replaceAll(RegExp(r'\(?\)?\-?\ ?'), ''),
                                      expireDate: expireDate,
                                    ),
                                  );
                            },
                            isLoading: state.createCardStatus.isInProgress,
                            text: LocaleKeys.add.tr(),
                            rippleColor: Colors.white.withAlpha(50),
                          ),
                        ),
                        AnimatedCrossFade(
                          duration: const Duration(milliseconds: 100),
                          firstChild: Column(
                            children: [
                              SizedBox(
                                height: MediaQuery.of(context).viewInsets.bottom,
                              )
                            ],
                          ),
                          secondChild: Column(
                            children: [
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
                                    style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.taxBreak),
                                  ),
                                  SvgPicture.asset(AppIcons.paylovIcon),
                                  context.locale.languageCode == "uz"
                                      ? Text(
                                          "  tomonidan qo'llab quvvatlanadi.",
                                          style: Theme.of(context).textTheme.labelMedium!.copyWith(color: AppColors.taxBreak),
                                        )
                                      : const SizedBox(),
                                ],
                              ),
                              SizedBox(height: MediaQuery.of(context).padding.bottom + 16)
                            ],
                          ),
                          crossFadeState: !value ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                        ),
                      ],
                    );
                  });
            },
          ),
          appBar: AppBar(
            elevation: 0,
            leadingWidth: 0,
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 16),
                Text(LocaleKeys.add_card.tr(), style: Theme.of(context).textTheme.displayMedium),
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
                // todo:
                // AddCreditCardTextField(
                //   controller: cardNameController,
                //   onChanged: (value) {},
                //   keyboardType: TextInputType.name,
                //   contentPadding: const EdgeInsets.all(12),
                //   labelText: LocaleKeys.card_name.tr(),
                //   hintText: LocaleKeys.enter_card_name.tr(),
                // ),
                DefaultTextField(
                  controller: cardController,
                  inputFormatters: [cardFormatter],
                  onChanged: (value) {
                    cardController.addListener(() {
                      valueListenableCardIcon.value = 0;
                      if (cardController.text.isNotEmpty) {
                        if (cardController.text.startsWith("4")) {
                          valueListenableCardIcon.value = 3;
                        } else if (cardController.text.startsWith("2") || cardController.text.startsWith("5")) {
                          valueListenableCardIcon.value = 4;
                        } else if (cardController.text.length >= 4) {
                          final first4Number = cardController.text.substring(0, 4);

                          if (first4Number == "8600") {
                            valueListenableCardIcon.value = 1;
                          } else if (first4Number == "9860") {
                            valueListenableCardIcon.value = 2;
                          } else {
                            valueListenableCardIcon.value = 0;
                          }
                        }
                      }
                      setState(() {});
                    });
                  },
                  keyboardType: TextInputType.number,
                  contentPadding: const EdgeInsets.all(12),
                  title: LocaleKeys.card_number.tr(),
                  hintText: "0000 0000 0000 0000",
                  suffix: ValueListenableBuilder<int>(
                    valueListenable: valueListenableCardIcon,
                    builder: (BuildContext context, value, Widget? child) {
                      return Padding(
                        padding: const EdgeInsets.all(12),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          transitionBuilder: (child, animation) {
                            return FadeTransition(
                              opacity: animation,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(-.3, 0),
                                  end: const Offset(0, 0),
                                ).animate(animation),
                                child: child,
                              ),
                            );
                          },
                          child: cardIcons[valueListenableCardIcon.value],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: DefaultTextField(
                        controller: cardValidController,
                        inputFormatters: [validityFormatter],
                        onChanged: (value) {},
                        keyboardType: TextInputType.number,
                        contentPadding: const EdgeInsets.all(12),
                        title: LocaleKeys.validity.tr(),
                        hintText: LocaleKeys.mm_yy.tr(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 200),
                        crossFadeState: (valueListenableCardIcon.value == 3 || valueListenableCardIcon.value == 4)
                            ? CrossFadeState.showSecond
                            : CrossFadeState.showFirst,
                        firstChild: const SizedBox(),
                        secondChild: DefaultTextField(
                          controller: cardCVVController,
                          inputFormatters: [cvvFormatter],
                          onChanged: (value) {},
                          keyboardType: TextInputType.number,
                          contentPadding: const EdgeInsets.all(12),
                          title: LocaleKeys.cvv_code.tr(),
                          hintText: "***",
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                  decoration: BoxDecoration(
                    color: AppColors.solitude,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          LocaleKeys.supported_cards.tr(),
                          style: context.textTheme.headlineSmall,
                        ),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset(AppIcons.uzcard),
                          const SizedBox(width: 8),
                          SvgPicture.asset(AppIcons.humo),
                          const SizedBox(width: 8),
                          SvgPicture.asset(AppIcons.visa),
                          const SizedBox(width: 8),
                          SvgPicture.asset(AppIcons.masterCard),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
