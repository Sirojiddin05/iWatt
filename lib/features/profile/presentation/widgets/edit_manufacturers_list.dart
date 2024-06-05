import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/error_state_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/modal_sheet_header.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/edit_car_bloc/edit_car_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/manufacturers_bloc/manufacturers_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/models_bloc/models_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/custom_model_item_mark.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/manufacturer_item.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class EditManufacturersList extends StatefulWidget {
  const EditManufacturersList({super.key});

  @override
  State<EditManufacturersList> createState() => _EditManufacturersListState();
}

class _EditManufacturersListState extends State<EditManufacturersList> {
  @override
  Widget build(BuildContext context) {
    return SheetWrapper(
      child: Column(
        children: [
          const ModalSheetHeaderWidget(
            title: LocaleKeys.brand_capital,
          ),
          BlocBuilder<ManufacturersBloc, ManufacturersState>(
            buildWhen: (o, n) => o.getManufacturers != n.getManufacturers,
            builder: (context, state) {
              if (state.getManufacturers.isInitial) {
                context.read<ManufacturersBloc>().add(GetManufacturers());
              }
              if (state.getManufacturers.isInProgress) {
                return const Expanded(
                  child: CircularProgressIndicator.adaptive(),
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
                  child: BlocBuilder<EditCarBloc, EditCarState>(
                    builder: (context, editState) {
                      return Paginator(
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
                          if (manufacturer.id == 0) {
                            return CustomModelItemMark(
                              title: manufacturer.name,
                              onTap: () {
                                context.read<EditCarBloc>().add(EditSetTemporaryManufacturer(manufacturer.id));
                              },
                              groupValue: editState.temporaryManufacturer,
                              value: manufacturer.id,
                              onModelChanged: (String value) {
                                // context.read<EditCarBloc>().add(EditSetCustomManufacturer(value));
                              },
                              customModel: '',
                              onManufacturerChanged: (String value) {
                                // context.read<EditCarBloc>().add(EditSetCustomManufacturer(value));
                              },
                              customManufacturer: '',
                            );
                          }
                          return ManufacturerItem(
                            onTap: () {
                              context.read<ModelsBloc>().add(SetManufacturerId(manufacturer.id));
                              context.read<EditCarBloc>().add(EditSetTemporaryManufacturer(manufacturer.id));
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
                      );
                    },
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
