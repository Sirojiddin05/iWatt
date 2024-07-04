import 'package:flutter/material.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/custom_indicator_pointer/base_indicator_effect.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/custom_indicator_pointer/base_indicator_painter.dart';
import 'package:i_watt_app/features/navigation/presentation/widgets/custom_indicator_pointer/worm_painter.dart';

/// Holds painting configuration to be used by [WormPainter]
class WormEffect extends BasicIndicatorEffect {
  /// The effect variant
  ///
  /// defaults to [WormType.normal]
  final WormType type;

  /// Default constructor
  const WormEffect({
    double offset = 16.0,
    super.dotWidth = 16.0,
    super.dotHeight = 16.0,
    super.spacing = 8.0,
    super.radius = 16,
    super.dotColor = Colors.grey,
    super.activeDotColor = Colors.indigo,
    super.strokeWidth = 1.0,
    super.paintStyle = PaintingStyle.fill,
    this.type = WormType.normal,
  });

  @override
  IndicatorPainter buildPainter(int count, double offset) {
    return WormPainter(count: count, offset: offset, effect: this);
  }
}

/// The Worm effect variants
enum WormType {
  /// Draws normal worm animation
  normal,

  /// Draws a thin worm animation
  thin,

  /// Draws normal worm animation that looks like
  /// it's under the background
  underground,

  /// Draws a thing worm animation that looks like
  /// it's under the background
  thinUnderground,
}
