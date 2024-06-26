import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/features/common/presentation/blocs/vendors_bloc/vendors_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_text_field.dart';

class SearchSliverDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Opacity(
        opacity: getOpacity(shrinkOffset),
        child: SearchField(
          searchIcon: AppIcons.searchLong,
          fillColor: AppColors.solitude,
          onChanged: (v) {
            context.read<VendorsBloc>().add(SearchVendorsEvent(searchPattern: v));
          },
        ),
      ),
    );
  }

  double getOpacity(double shrinkOffset) {
    if (shrinkOffset == 0) {
      return 1;
    }
    if (shrinkOffset >= 44) {
      return 0;
    }
    final double opacity = 1 - (shrinkOffset / 44);
    return opacity;
  }

  @override
  double get maxExtent => 52;

  @override
  double get minExtent => 52;

  @override
  bool shouldRebuild(covariant SearchSliverDelegate oldDelegate) => false;
}
