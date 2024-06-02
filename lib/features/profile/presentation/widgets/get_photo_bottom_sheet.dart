import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_custom_tappable_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> showGetPhotoSheet(BuildContext context) async {
  return await showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    builder: (context) => const GetPhotoSheet(),
  );
}

class GetPhotoSheet extends StatefulWidget {
  const GetPhotoSheet({super.key});

  @override
  State<GetPhotoSheet> createState() => _GetPhotoSheetState();
}

class _GetPhotoSheetState extends State<GetPhotoSheet> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SheetHeaderWidget(title: LocaleKeys.change_profile_photo.tr()),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
            child: Row(
              children: [
                Expanded(
                  child: WCustomTappableButton(
                    onTap: () {
                      ImagePicker().pickImage(source: ImageSource.camera).then((value) {
                        if (value != null) {
                          Navigator.pop(context, value.path);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    rippleColor: context.theme.primaryColor.withAlpha(50),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 50),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.fieldBorderZircon),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppIcons.camera,
                            color: context.theme.primaryColor,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            LocaleKeys.camera.tr(),
                            style: context.textTheme.titleLarge?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: WCustomTappableButton(
                    onTap: () {
                      ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
                        if (value != null) {
                          Navigator.pop(context, value.path);
                        }
                      });
                    },
                    borderRadius: BorderRadius.circular(8),
                    rippleColor: context.theme.primaryColor.withAlpha(50),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 50),
                      decoration: BoxDecoration(
                        border: Border.all(width: 1, color: AppColors.fieldBorderZircon),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(
                            AppIcons.imageSquare,
                            color: context.theme.primaryColor,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            LocaleKeys.gallery.tr(),
                            style: context.textTheme.titleLarge?.copyWith(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
