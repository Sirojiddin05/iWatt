import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/authorization/presentation/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/pages/qr_share.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/auhed_user_profile_body.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/un_authed_user_body.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ScrollController controller;
  late final ProfileBloc profileBloc;

  @override
  void initState() {
    super.initState();
    controller = ScrollController()..addListener(controllerListener);
    profileBloc = ProfileBloc()..add(GetUserData());
  }

  void controllerListener() {}

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: profileBloc,
      child: Scaffold(
        appBar: AppBarWrapper(
          child: Row(
            children: [
              const SizedBox(width: 16),
              Image.asset(context.themedIcons.splashLogo, width: 80, height: 20),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.of(context, rootNavigator: true).push(
                  MaterialWithModalsPageRoute(
                    builder: (ctx) => const QrSharePage(),
                  ),
                ),
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: SvgPicture.asset(AppIcons.qrCode),
                ),
              )
            ],
          ),
        ),
        body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          buildWhen: (o, n) => o.authenticationStatus != n.authenticationStatus,
          builder: (context, state) {
            if (false) {
              return AuthedUserProfileBody(
                controller: controller,
              );
            }
            return UnAuthedUserBody(
              controller: controller,
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
