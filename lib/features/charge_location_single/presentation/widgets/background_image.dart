import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/blocs/charge_location_single_bloc/charge_location_single_bloc.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/logo_container.dart';

class BackgroundImage extends StatelessWidget {
  final ValueNotifier<double> headerOpacity;

  const BackgroundImage({
    super.key,
    required this.headerOpacity,
  });

  @override
  Widget build(BuildContext context) {
    final paddingTop = Platform.isIOS ? context.sizeOf.height * 0.16 : context.sizeOf.height * 0.14;
    return Positioned(
      top: 0,
      right: 0,
      left: 0,
      bottom: 0,
      child: ValueListenableBuilder(
        valueListenable: headerOpacity,
        builder: (context, value, child) {
          return Opacity(
            opacity: value,
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      width: double.infinity,
                      height: context.sizeOf.height * 0.3,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(AppImages.locationSingleHeaderBg),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Spacer()
                  ],
                ),
                Positioned(
                  left: 16,
                  top: paddingTop,
                  child: BlocBuilder<ChargeLocationSingleBloc, ChargeLocationSingleState>(
                    builder: (context, state) {
                      return LogoContainer(
                        logo: state.location.vendor.logo,
                      );
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
