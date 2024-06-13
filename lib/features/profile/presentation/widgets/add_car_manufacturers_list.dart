import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/error_state_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
import 'package:i_watt_app/features/common/presentation/widgets/search_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/add_car_bloc/add_car_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/manufacturers_bloc/manufacturers_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/models_bloc/models_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/manufacturer_item.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class AddCarManufacturersList extends StatefulWidget {
  const AddCarManufacturersList({super.key});

  @override
  State<AddCarManufacturersList> createState() => _AddCarManufacturersListState();
}

class _AddCarManufacturersListState extends State<AddCarManufacturersList> with TickerProviderStateMixin {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return WKeyboardDismisser(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: SearchField(
              controller: controller,
              searchIcon: AppIcons.searchLong,
              onChanged: (v) {
                context.read<ManufacturersBloc>().add(SearchManufacturers(v));
              },
            ),
          ),
          BlocBuilder<ManufacturersBloc, ManufacturersState>(
            buildWhen: (o, n) => o.getManufacturers != n.getManufacturers,
            builder: (context, state) {
              if (state.getManufacturers.isInitial) {
                context.read<ManufacturersBloc>().add(GetManufacturers());
              }
              if (state.getManufacturers.isInProgress) {
                return const Expanded(
                  child: Center(child: CircularProgressIndicator.adaptive()),
                );
              }
              if (state.getManufacturers.isSuccess) {
                if (state.manufacturers.isEmpty) {
                  return Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.center,
                      child: EmptyStateWidget(
                        title: LocaleKeys.nothing_found.tr(),
                        subtitle: LocaleKeys.nothing_found_to_your_request.tr(),
                        icon: AppImages.searchEmpty,
                      ),
                    ),
                  );
                }
                return Expanded(
                  child: Paginator(
                    physics: const BouncingScrollPhysics(),
                    separatorBuilder: (context, index) {
                      return Builder(builder: (ctx) {
                        if (index + 1 < state.manufacturers.length) {
                          return Divider(
                            height: 0,
                            thickness: 1,
                            color: context.theme.dividerColor,
                            indent: 58,
                          );
                        }
                        return const SizedBox();
                      });
                    },
                    itemBuilder: (context, index) {
                      final manufacturer = state.manufacturers[index];
                      return ManufacturerItem(
                        onTap: () {
                          context.read<ModelsBloc>().add(SetManufacturerId(manufacturer.id));
                          context.read<AddCarBloc>().add(SetManufacturer(manufacturer));
                        },
                        title: manufacturer.name,
                        icon: manufacturer.id == 0 ? AppIcons.questionMark : manufacturer.icon,
                      );
                    },
                    itemCount: state.manufacturers.length,
                    paginatorStatus: state.getManufacturers,
                    fetchMoreFunction: () {
                      context.read<ManufacturersBloc>().add(GetMoreManufacturers());
                    },
                    hasMoreToFetch: state.fetchMore,
                    errorWidget: const SizedBox.shrink(),
                    padding: EdgeInsets.only(bottom: MediaQuery.paddingOf(context).bottom + 16),
                  ),
                );
              }
              if (state.getManufacturers.isFailure) {
                return const ErrorStateTextWidget();
              }
              return const Spacer();
            },
          ),
        ],
      ),
    );
  }
}
