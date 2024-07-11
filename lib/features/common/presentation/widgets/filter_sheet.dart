import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/core/config/app_constants.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/presentation/blocs/filter_bloc/filter_bloc.dart';
import 'package:i_watt_app/features/common/presentation/widgets/aplly_filter_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_first_page.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_header.dart';
import 'package:i_watt_app/features/common/presentation/widgets/filter_second_page.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class FilterSheet extends StatefulWidget {
  final Function(
    List<int> powerTypes,
    List<int> connectorType,
    List<IdNameEntity> vendors,
    List<String> locationStatuses,
    bool integrated,
  ) onChanged;
  final List<int> selectedPowerTypes;
  final List<int> selectedConnectorTypes;
  final List<IdNameEntity> selectedVendors;
  final List<String> locationStatuses;
  final bool integrated;

  const FilterSheet({
    super.key,
    required this.onChanged,
    required this.selectedPowerTypes,
    required this.selectedConnectorTypes,
    required this.selectedVendors,
    required this.locationStatuses,
    required this.integrated,
  });

  @override
  State<FilterSheet> createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  late final ScrollController firstPageController;
  late final ScrollController secondPageController;
  late final PageController pageController;
  late final ValueNotifier<bool> haShadow;
  late final FilterBloc filterBloc;

  @override
  void initState() {
    super.initState();
    haShadow = ValueNotifier<bool>(false);
    filterBloc = FilterBloc(
      defaultSelectedConnectorTypes: widget.selectedConnectorTypes,
      defaultSelectedPowerTypes: widget.selectedPowerTypes,
      defaultSelectedVendors: widget.selectedVendors,
      defaultSelectedStatuses: widget.locationStatuses,
      integrated: widget.integrated,
    );
    pageController = PageController();
    firstPageController = ScrollController()..addListener(firstPageControllerListener);
    secondPageController = ScrollController()..addListener(secondPageControllerListener);
  }

  void firstPageControllerListener() {
    if (firstPageController.offset > 10 && !haShadow.value) {
      haShadow.value = true;
    } else if (firstPageController.offset < 10 && haShadow.value) {
      haShadow.value = false;
    }
  }

  void secondPageControllerListener() {
    if (secondPageController.offset > 50 && !haShadow.value) {
      haShadow.value = true;
    } else if (secondPageController.offset < 50 && haShadow.value) {
      haShadow.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<FilterBloc>.value(
      value: filterBloc,
      child: BlocListener<FilterBloc, FilterState>(
        listenWhen: (previous, current) => previous.page != current.page,
        listener: (context, state) {
          pageController.animateToPage(
            state.page,
            duration: AppConstants.animationDuration,
            curve: Curves.decelerate,
          );
          haShadow.value = false;
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            color: context.themedColors.whiteToTangaroa2,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ValueListenableBuilder(
                valueListenable: haShadow,
                builder: (context, value, child) {
                  return FilterHeader(hasShadow: value);
                },
              ),
              Expanded(
                child: PageView(
                  controller: pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    FilterFirstPage(controller: firstPageController),
                    FilterSecondPage(controller: secondPageController),
                  ],
                ),
              ),
              BlocBuilder<FilterBloc, FilterState>(
                builder: (context, state) {
                  return ApplyFilterButton(
                    text: state.page == 0 ? LocaleKeys.apply.tr() : LocaleKeys.confirm.tr(),
                    onTap: () {
                      if (state.page == 0) {
                        widget.onChanged(
                          state.powerTypes,
                          state.connectorTypes,
                          state.vendors,
                          state.filterKeys,
                          state.integrated,
                        );
                      } else {
                        context.read<FilterBloc>().add(const SetVendorsEvent());
                      }
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
