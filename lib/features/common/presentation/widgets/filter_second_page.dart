import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/blocs/filter_bloc/filter_bloc.dart';
import 'package:i_watt_app/features/common/presentation/blocs/vendors_bloc/vendors_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_sliver_delegate.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_check_box_tile.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';

class FilterSecondPage extends StatefulWidget {
  final ScrollController controller;

  const FilterSecondPage({super.key, required this.controller});

  @override
  State<FilterSecondPage> createState() => _FilterSecondPageState();
}

class _FilterSecondPageState extends State<FilterSecondPage> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NestedScrollView(
      controller: widget.controller,
      headerSliverBuilder: (ctx, innerBoxIsScrolled) {
        return [
          SliverPersistentHeader(
            floating: true,
            delegate: SearchSliverDelegate(),
          ),
        ];
      },
      body: WKeyboardDismisser(
        child: BlocBuilder<VendorsBloc, VendorsState>(
          builder: (context, state) {
            final vendors = state.vendors;
            context.read<FilterBloc>().add(ChangeVendorsList(vendors: vendors));
            return Paginator(
              paginatorStatus: FormzSubmissionStatus.success,
              itemBuilder: (ctx, index) {
                return BlocBuilder<FilterBloc, FilterState>(
                  buildWhen: (o, n) => o.temporaryVendors != n.temporaryVendors,
                  builder: (context, filterState) {
                    final selectedVendors = filterState.temporaryVendors;
                    final selectedVendorIds = List<int>.generate(selectedVendors.length, (index) => selectedVendors[index].id);
                    final vendor = vendors[index];
                    return WCheckBoxTile(
                      title: vendor.name,
                      icon: vendor.logo,
                      isSelectedDefault: selectedVendorIds.contains(vendor.id),
                      onCheck: (val) {
                        if (vendor.id == 0) {
                          if (selectedVendorIds.contains(vendor.id)) {
                            context.read<FilterBloc>().add(UnSelectAllVendorsEvent());
                          } else {
                            context.read<FilterBloc>().add(SelectAllVendorsEvent(vendors));
                          }
                        } else {
                          if (selectedVendorIds.contains(vendor.id)) {
                            context.read<FilterBloc>().add(UnSelectVendorEvent(vendor: vendor));
                          } else {
                            context.read<FilterBloc>().add(SelectVendorEvent(vendor: vendor));
                          }
                        }
                      },
                    );
                  },
                );
              },
              separatorBuilder: (ctx, index) {
                if (index == vendors.length - 1) {
                  return const SizedBox.shrink();
                }
                return Divider(
                  color: context.theme.dividerColor,
                  height: 0,
                  thickness: 1,
                  indent: 68,
                );
              },
              itemCount: vendors.length,
              fetchMoreFunction: () {
                context.read<VendorsBloc>().add(GetMoreVendorsEvent());
              },
              hasMoreToFetch: state.hasMoreToFetch,
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
