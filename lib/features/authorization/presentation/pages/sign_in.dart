import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/authentication_status.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/authorization/data/repositories_impl/sign_in_repository_impl.dart';
import 'package:i_watt_app/features/authorization/domain/usecases/login_usecase.dart';
import 'package:i_watt_app/features/authorization/domain/usecases/login_with_qr_usecase.dart';
import 'package:i_watt_app/features/authorization/domain/usecases/verify_code_usecase.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:i_watt_app/features/authorization/presentation/pages/code_verification_page.dart';
import 'package:i_watt_app/features/authorization/presentation/pages/login_with_qr.dart';
import 'package:i_watt_app/features/common/presentation/widgets/base_auth_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/common_loader_dialog.dart';
import 'package:i_watt_app/features/common/presentation/widgets/phone_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:i_watt_app/service_locator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late final TextEditingController phoneController;
  late final ValueNotifier<bool> phoneFieldHasError;
  late final SignInBloc signInBloc;

  @override
  void initState() {
    super.initState();
    signInBloc = SignInBloc(
      loginUseCase: LoginUseCase(
        serviceLocator<SignInRepositoryImpl>(),
      ),
      verifyCodeUseCase: VerifyCodeUseCase(
        serviceLocator<SignInRepositoryImpl>(),
      ),
      loginWithQrUseCase: LoginWithQrUseCase(
        serviceLocator<SignInRepositoryImpl>(),
      ),
    );
    phoneController = TextEditingController();
    phoneFieldHasError = ValueNotifier<bool>(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SignInBloc>.value(
      value: signInBloc,
      child: BaseAuthWrapper(
        title: LocaleKeys.authorization.tr(),
        subtitle: LocaleKeys.you_need_input_phone_number_for_login.tr(),
        bodyWidgets: [
          const SizedBox(height: 32),
          BlocListener<SignInBloc, SignInState>(
            listenWhen: (o, n) => o.signInStatus != n.signInStatus,
            listener: (context, state) {
              if (state.signInStatus.isFailure) {
                phoneFieldHasError.value = state.signInStatus.isFailure;
              }
            },
            child: ValueListenableBuilder<bool>(
              valueListenable: phoneFieldHasError,
              builder: (context, hasError, child) {
                return PhoneTextField(
                  controller: phoneController,
                  onChanged: (value) {
                    if (phoneFieldHasError.value) {
                      phoneFieldHasError.value = false;
                    }
                    signInBloc.add(ChangePhone(phone: value));
                  },
                  onSubmitted: (value) {
                    signInBloc.add(SignIn());
                  },
                  hasError: hasError,
                );
              },
            ),
          ),
        ],
        bottomWidgets: [
          BlocListener<SignInBloc, SignInState>(
            listenWhen: (o, n) {
              final statusChanged = o.signInWithQrStatus != n.signInWithQrStatus;
              final messageChanged = o.signInWithQrErrorMessage != n.signInWithQrErrorMessage;
              return statusChanged || messageChanged;
            },
            listener: (context, state) {
              if (state.signInWithQrStatus.isInProgress) {
                showCommonLoaderDialog(context);
              } else if (state.signInWithQrStatus.isSuccess) {
                context.read<AuthenticationBloc>().add(
                      AuthenticationStatusChanged(
                        authenticationStatus: AuthenticationStatus.authenticated,
                        isRebuild: false,
                      ),
                    );
                Navigator.of(context)
                  ..pop()
                  ..pop();
              } else if (state.signInWithQrStatus.isFailure) {
                Navigator.pop(context);
                context.showPopUp(
                  context,
                  PopUpStatus.failure,
                  message: state.signInWithQrErrorMessage,
                );
              }
            },
            child: WButton(
              color: context.themedColors.solitudeToSolitudeO4,
              margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppIcons.qrIcon),
                  const SizedBox(width: 6),
                  Text(
                    LocaleKeys.authorization_through_qr.tr(),
                    style: context.textTheme.bodySmall,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialWithModalsPageRoute(
                    builder: (ctx) => const LoginWithQr(),
                  ),
                ).then((value) {
                  if (value != null && value is String && value.isNotEmpty && value.contains('refresh ')) {
                    final token = value.replaceAll('refresh ', '');
                    signInBloc.add(SignInWithQrEvent(token: token));
                  }
                });
              },
            ),
          ),
          BlocConsumer<SignInBloc, SignInState>(
            listenWhen: (o, n) {
              final isStatusChanged = o.signInStatus != n.signInStatus;
              final isErrorMessageChanged = o.signInErrorMessage != n.signInErrorMessage;
              return isStatusChanged || isErrorMessageChanged;
            },
            listener: (context, state) {
              if (state.signInStatus.isFailure) {
                context.showPopUp(
                  context,
                  PopUpStatus.failure,
                  message: state.signInErrorMessage,
                );
              } else if (state.signInStatus.isSuccess) {
                Navigator.push(
                  context,
                  MaterialWithModalsPageRoute(
                    builder: (ctx) => BlocProvider<SignInBloc>.value(
                      value: signInBloc,
                      child: const CodeVerificationPage(),
                    ),
                  ),
                ).then((value) => signInBloc.add(const ChangeOTP(otp: '')));
              }
            },
            buildWhen: (o, n) {
              final isPhoneChanged = o.tempPhone.length != n.tempPhone.length;
              final isStatusChanged = o.signInStatus != n.signInStatus;
              return isPhoneChanged || isStatusChanged;
            },
            builder: (context, state) {
              return WButton(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                text: LocaleKeys.resume.tr(),
                isLoading: state.signInStatus.isInProgress,
                isDisabled: state.tempPhone.length < 12,
                onTap: () => signInBloc.add(SignIn()),
              );
            },
          ),
        ],
      ),
    );
  }
}
