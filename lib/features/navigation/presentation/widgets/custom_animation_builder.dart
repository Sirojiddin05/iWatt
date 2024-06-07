import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/shimmer_loader.dart';
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
    // _controller = CachedVideoPlayerController.network(
    //     "http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4");
    // _controller.initialize().then((value) {
    //   _controller.play();
    //   setState(() {});
    // });
    super.initState();
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
          child: AnimatedBuilder(
            animation: widget.pageController,
            builder: (context, child) {
              double pageOffset = 0;
              double pageOffset2 = 0;
              if (widget.index == 1) {
                pageOffset = 1;
                pageOffset2 = 1;
              }
              if (widget.pageController.position.haveDimensions) {
                if (widget.pageController.page! >= widget.index) {
                  pageOffset2 = widget.pageController.page! - widget.index;
                } else if (widget.pageController.page! < widget.index) {
                  pageOffset2 = widget.index - widget.pageController.page!;
                }
                pageOffset = widget.index - widget.pageController.page!;
              }
              double angle = pageOffset * 1.3;
              // if (angle > .85) {
              //   angle = .85;
              // } else if (angle < -.85) {
              //   angle = -.85;
              // }
              return Stack(
                alignment: Alignment.center,
                children: [
                  Positioned(
                    top: ((pageOffset2) * 100),
                    bottom: 0,
                    child: Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.identity()
                        ..setEntry(3, 2, .0008)
                        ..rotateY(angle),
                      child: isImage
                          ? WImage(imageUrl: widget.feature.file, fit: BoxFit.fitHeight)
                          : controller.value.isInitialized
                              ? AspectRatio(
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
                                )
                              : Shimmer(
                                  child: ShimmerLoading(
                                    isLoading: true,
                                    child: ShimmerContainer(
                                      width: double.infinity,
                                      height: context.sizeOf.height * .65,
                                    ),
                                  ),
                                ),
                      // Image.asset('assets/images/phone.png'),
                    ),
                  ),
                ],
              );
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
