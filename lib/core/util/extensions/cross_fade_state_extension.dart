import 'package:flutter/widgets.dart';

extension CrossFade on CrossFadeState {
  bool get isFirst => this == CrossFadeState.showFirst;

  bool get isSecond => this == CrossFadeState.showSecond;
}
