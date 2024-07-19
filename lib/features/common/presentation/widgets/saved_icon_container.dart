import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/authorization/presentation/pages/sign_in.dart';
import 'package:i_watt_app/features/common/presentation/blocs/save_unsave_bloc/save_un_save_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/adaptive_dialog.dart';
import 'package:i_watt_app/features/list/data/repository_impl/charge_locations_repository_impl.dart';
import 'package:i_watt_app/features/list/domain/entities/charge_location_entity.dart';
import 'package:i_watt_app/features/list/domain/usecases/save_unave_location_usecase.dart';
import 'package:i_watt_app/service_locator.dart';
import 'package:vibration/vibration.dart';

class SavedUnSaveButton extends StatelessWidget {
  final double size;
  final ChargeLocationEntity location;

  const SavedUnSaveButton({super.key, required this.location, this.size = 20});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SaveUnSaveBloc>(
      key: ValueKey(location.id.toString() + location.isFavorite.toString()),
      create: (context) => SaveUnSaveBloc(
        location: location,
        saveChargeLocationUseCase: SaveUnSaveChargeLocationUseCase(
          serviceLocator<ChargeLocationsRepositoryImpl>(),
        ),
      ),
      child: BlocConsumer<SaveUnSaveBloc, SaveUnSaveState>(
        listenWhen: (o, n) => o.status != n.status,
        listener: (context, state) {
          if (state.status.isFailure) {
            context.showPopUp(context, PopUpStatus.failure, message: state.error);
          }
        },
        builder: (context, state) {
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () async {
              if (Platform.isAndroid && (await Vibration.hasVibrator() ?? false)) {
                Vibration.vibrate(amplitude: 32, duration: 40);
              } else if (Platform.isIOS) {
                HapticFeedback.lightImpact();
              }
              if (context.read<AuthenticationBloc>().state.authenticationStatus.isUnAuthenticated) {
                showLoginDialog(
                  context,
                  onConfirm: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SignInPage()));
                  },
                );
              } else {
                context.read<SaveUnSaveBloc>().add(const SaveEvent());
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: SvgPicture.asset(
                state.location.isFavorite ? AppIcons.saved : AppIcons.unSaved,
                height: size,
                width: size,
              ),
            ),
          );
        },
      ),
    );
  }
}
