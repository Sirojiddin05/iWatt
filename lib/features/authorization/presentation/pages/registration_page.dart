import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/formatter.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/registration_bloc/registration_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/base_auth_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/date_picker_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/gender_selector_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  late final TextEditingController fullNameController;
  late final RegistrationBloc registrationBloc;

  @override
  void initState() {
    super.initState();
    registrationBloc = RegistrationBloc();
    fullNameController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegistrationBloc>.value(
      value: registrationBloc,
      child: BaseAuthWrapper(
        title: LocaleKeys.registration.tr(),
        subtitle: LocaleKeys.input_necessary_fields.tr(),
        bodyWidgets: [
          const SizedBox(height: 32),
          DefaultTextField(
            title: '${LocaleKeys.full_name.tr()} *',
            controller: fullNameController,
            inputFormatters: [
              Formatters.onlyLetters,
            ],
            keyboardType: TextInputType.name,
            onChanged: (val) => registrationBloc.add(ChangeFullName(val)),
          ),
          const SizedBox(height: 32),
          DatePickerWidget(
            onChanged: (DateTime date) => registrationBloc.add(
              ChangeBirthDate(date),
            ),
          ),
          const SizedBox(height: 32),
          GenderSelectorWidget(
            onChanged: (gender) => registrationBloc.add(
              ChangeGender(gender),
            ),
          ),
        ],
        bottomWidgets: [
          BlocConsumer<RegistrationBloc, RegistrationState>(
            listenWhen: (o, n) => o.registerStatus != n.registerStatus,
            listener: (BuildContext context, RegistrationState state) {
              if (state.registerStatus.isSuccess) {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
              if (state.registerStatus.isFailure) {
                context.showPopUp(
                  context,
                  PopUpStatus.failure,
                  message: state.errorMessage,
                );
              }
            },
            builder: (context, state) {
              return WButton(
                margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                text: LocaleKeys.resume.tr(),
                isLoading: state.registerStatus.isInProgress,
                isDisabled: state.isButtonDisabled(),
                onTap: () => registrationBloc.add(const Register()),
              );
            },
          ),
        ],
      ),
    );
  }
}
