import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_image.dart';
import 'package:i_watt_app/features/navigation/domain/entity/version_features_entity.dart';

class CustomBuilderAnimation extends StatefulWidget {
  final int index;
  final VersionFeaturesEntity feature;
  final PageController pageController;

  const CustomBuilderAnimation({
    super.key,
    required this.index,
    required this.pageController,
    required this.feature,
  });

  @override
  State<CustomBuilderAnimation> createState() => _CustomBuilderAnimationState();
}

class _CustomBuilderAnimationState extends State<CustomBuilderAnimation> {
  late CachedVideoPlayerPlusController controller;
  final List<String> imageExtensions = ['png', 'jpg', 'jpeg', 'webp'];
  late bool isImage;

  @override
  void initState() {
    super.initState();
    isImage = (imageExtensions.any((e) => widget.feature.file.toLowerCase().endsWith(e)));
    if (!isImage) {
      controller = CachedVideoPlayerPlusController.networkUrl(Uri.parse(widget.feature.file))
        ..addListener(() async {
          final position = await controller.position;
          if ((position?.inMilliseconds ?? 0) >= controller.value.duration.inMilliseconds) {
            // controller.play();
          }
        })
        ..initialize().then((value) async {
          controller.setLooping(true);
          controller.play();
          if (mounted) setState(() {});
        });
    }
    widget.pageController.addListener(() {
      if (!isImage) {
        if (widget.pageController.page != widget.index) {
          controller.pause();
        } else {
          controller.play();
        }
      }
    });
  }

  @override
  void dispose() {
    if (!isImage) controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Builder(
            builder: (context) {
              if (isImage) {
                return WImage(imageUrl: widget.feature.file, fit: BoxFit.fitHeight);
              } else {
                if (controller.value.isInitialized) {
                  return AspectRatio(
                    aspectRatio: controller.value.aspectRatio,
                    child: GestureDetector(
                      onTapDown: (event) {
                        controller.pause();
                      },
                      onTapUp: (event) {
                        controller.play();
                      },
                      onTapCancel: () {
                        controller.play();
                      },
                      child: CachedVideoPlayerPlus(controller),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
            },
          ),
        ),
        Container(
          width: double.infinity,
          color: context.theme.appBarTheme.backgroundColor,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(widget.feature.title, style: context.textTheme.displayLarge),
              const SizedBox(height: 8),
              Text(
                widget.feature.description,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
