import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/phone_edit_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/pin_code_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/resend_otp_code.dart';
import 'package:i_watt_app/features/common/presentation/widgets/resend_otp_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_close_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/credit_cards_bloc/credit_cards_bloc.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class CodeVerificationBottomSheet extends StatefulWidget {
  const CodeVerificationBottomSheet({super.key});

  @override
  State<CodeVerificationBottomSheet> createState() => _CodeVerificationBottomSheetState();
}

class _CodeVerificationBottomSheetState extends State<CodeVerificationBottomSheet> {
  late ValueNotifier<bool> valueListenable;

  late final TextEditingController pinCodeController;
  late final ValueNotifier<bool> pinCodeError;
  late final FocusNode focusNode;

  @override
  void initState() {
    valueListenable = ValueNotifier<bool>(false);
    pinCodeController = TextEditingController();
    pinCodeError = ValueNotifier<bool>(false);
    focusNode = FocusNode()..requestFocus();
    super.initState();
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
                      BlocListener<CreditCardsBloc, CreditCardsState>(
                        listener: (context, state) {},
                        child: WButton(
                          margin: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.of(context).padding.bottom + 16),
                          onTap: () async {
                            context.read<CreditCardsBloc>().add(
                                  ConfirmCreditCardEvent(
                                    onError: (message) {
                                      context.showPopUp(
                                        context,
                                        PopUpStatus.failure,
                                        message: message,
                                      );
                                    },
                                    onSuccess: () {
                                      Navigator.of(context).pop();
                                      Navigator.of(context).pop(true);
                                    },
                                    otp: pinCodeController.text,
                                  ),
                                );
                          },
                          isLoading: state.confirmCardStatus.isInProgress,
                          text: LocaleKeys.add.tr(),
                          rippleColor: Colors.white.withAlpha(50),
                        ),
                      ),
                    ],
                  );
                },
              );
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  LocaleKeys.we_send_otp_to_your_phone.tr(),
                  style: context.textTheme.labelLarge!.copyWith(
                    color: AppColors.blueBayoux,
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 8),
                BlocBuilder<CreditCardsBloc, CreditCardsState>(
                  builder: (context, state) {
                    return PhoneEditContainer(
                      phone: 'state.verifiedPhone',
                      phoneWithCountryCode: state.otpSentPhone,
                      hasEdit: false,
                      margin: const EdgeInsets.only(right: 14),
                    );
                  },
                ),
                const SizedBox(height: 32),
                Text(
                  LocaleKeys.input_code.tr(),
                  style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                ValueListenableBuilder<bool>(
                  valueListenable: pinCodeError,
                  builder: (context, hasError, child) {
                    return WPinCodeTextField(
                      hasError: hasError,
                      pinCodeController: pinCodeController,
                      focusNode: focusNode,
                      onChanged: (val) {
                        if (pinCodeError.value) {
                          pinCodeError.value = false;
                        }
                        // context.read<SignInBloc>().add(ChangeOTP(otp: pinCodeController.text));
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 26,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const ResendOtpText(),
                      BlocBuilder<CreditCardsBloc, CreditCardsState>(
                        buildWhen: (o, n) => o.codeAvailableTime != n.codeAvailableTime,
                        builder: (ctx, state) {
                          return ResendOtpWidget(
                            leftSeconds: state.codeAvailableTime,
                            onResend: () {
                              context.read<CreditCardsBloc>().add(const ResendCode());
                            },
                          );
                        },
                      )
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
