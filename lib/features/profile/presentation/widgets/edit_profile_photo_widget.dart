import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/get_photo_bottom_sheet.dart';

class EditProfilePhotoWidget extends StatelessWidget {
  final String photo;
  final ValueChanged<String> onChanged;

  const EditProfilePhotoWidget({super.key, required this.photo, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showGetPhotoSheet(context).then((value) {
          if (value is String) onChanged(value);
        });
      },
      child: SizedBox(
        width: 80,
        height: 80,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(90),
          child: Stack(
            children: [
              Positioned.fill(
                child: photo.startsWith('http') || photo.isEmpty
                    ? CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: photo,
                        errorWidget: (context, url, error) {
                          return Container(
                            alignment: Alignment.center,
                            color: context.theme.dividerColor,
                            child: SvgPicture.asset(AppIcons.camera),
                          );
                        },
                      )
                    : Image.file(File(photo), fit: BoxFit.cover),
              ),
              if (photo.isNotEmpty) Positioned.fill(child: ColoredBox(color: AppColors.nero.withOpacity(.28))),
              if (photo.isNotEmpty)
                Positioned(
                  left: 24,
                  right: 24,
                  top: 24,
                  bottom: 24,
                  child: SvgPicture.asset(AppIcons.penSquare),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
