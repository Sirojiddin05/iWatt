import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:i_watt_app/features/authorization/presentation/pages/registration_page.dart';
import 'package:i_watt_app/features/authorization/presentation/widgets/blocked_sheet.dart';
import 'package:i_watt_app/features/common/presentation/widgets/base_auth_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/phone_edit_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/pin_code_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/resend_otp_code.dart';
import 'package:i_watt_app/features/common/presentation/widgets/resend_otp_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CodeVerificationPage extends StatefulWidget {
  const CodeVerificationPage({super.key});

  @override
  State<CodeVerificationPage> createState() => _CodeVerificationPageState();
}

class _CodeVerificationPageState extends State<CodeVerificationPage> {
  late final TextEditingController pinCodeController;
  late final ValueNotifier<bool> pinCodeError;
  late final FocusNode focusNode;

  @override
  void initState() {
    super.initState();
    pinCodeController = TextEditingController();
    pinCodeError = ValueNotifier<bool>(false);
    focusNode = FocusNode()..requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return BaseAuthWrapper(
      title: LocaleKeys.verification_code.tr(),
      subtitle: LocaleKeys.we_send_otp_to_your_phone.tr(),
      bodyWidgets: [
        const SizedBox(height: 8),
        BlocBuilder<SignInBloc, SignInState>(
          buildWhen: (o, n) => o.verifiedPhone != n.verifiedPhone,
          builder: (context, state) {
            return PhoneEditContainer(
              phone: state.verifiedPhone,
              hasEdit: true,
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
        BlocListener<SignInBloc, SignInState>(
          listenWhen: (o, n) => o.verifyCodeStatus != n.verifyCodeStatus,
          listener: (context, state) {
            if (state.verifyCodeStatus.isFailure) {
              pinCodeError.value = true;
            }
          },
          child: ValueListenableBuilder<bool>(
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
                  context.read<SignInBloc>().add(ChangeOTP(otp: pinCodeController.text));
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 26,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const ResendOtpText(),
              BlocBuilder<SignInBloc, SignInState>(
                buildWhen: (o, n) => o.codeAvailableTime != n.codeAvailableTime,
                builder: (ctx, state) {
                  return ResendOtpWidget(
                    leftSeconds: state.codeAvailableTime,
                    onResend: () {
                      context.read<SignInBloc>().add(ResendCode());
                    },
                  );
                },
              )
            ],
          ),
        ),
      ],
      bottomWidgets: [
        BlocConsumer<SignInBloc, SignInState>(
          listenWhen: (o, n) {
            final isStatusChanged = o.verifyCodeStatus != n.verifyCodeStatus;
            final isErrorMessageChanged = o.verifyCodeErrorMessage != n.verifyCodeErrorMessage;
            return isStatusChanged || isErrorMessageChanged;
          },
          listener: (context, state) {
            if (state.verifyCodeStatus.isFailure) {
              context.showPopUp(
                context,
                PopUpStatus.failure,
                message: state.verifyCodeErrorMessage,
              );
              if (state.isUserBlocked) {
                showModalBottomSheet(
                  context: context,
                  enableDrag: false,
                  isDismissible: false,
                  backgroundColor: Colors.transparent,
                  builder: (ctx) {
                    return const BlockedSheet();
                  },
                );
              }
            } else if (state.verifyCodeStatus.isSuccess) {
              if (state.isNewUser) {
                Navigator.push(
                  context,
                  MaterialWithModalsPageRoute(
                    builder: (ctx) => const RegistrationPage(),
                  ),
                );
              } else {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            }
          },
          buildWhen: (o, n) {
            final isOtpChanged = o.otp.length != n.otp.length;
            final isStatusChanged = o.verifyCodeStatus != n.verifyCodeStatus;
            return isOtpChanged || isStatusChanged;
          },
          builder: (context, state) {
            return WButton(
              key: UniqueKey(),
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
              text: LocaleKeys.resume.tr(),
              isLoading: state.verifyCodeStatus.isInProgress,
              isDisabled: state.otp.length < 6,
              onTap: () => context.read<SignInBloc>().add(
                    VerifyCode(
                      code: pinCodeController.text,
                    ),
                  ),
            );
          },
        ),
      ],
    );
  }
}
