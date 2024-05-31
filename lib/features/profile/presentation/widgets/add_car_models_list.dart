import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/common/presentation/widgets/error_state_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/add_car_bloc/add_car_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/models_bloc/models_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/custom_model_item.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/model_item.dart';

class AddCarModelsList extends StatefulWidget {
  const AddCarModelsList({super.key});

  @override
  State<AddCarModelsList> createState() => _AddCarModelsListState();
}

class _AddCarModelsListState extends State<AddCarModelsList> with TickerProviderStateMixin {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ModelsBloc, ModelsState>(
      buildWhen: (o, n) => o.getModelsStatus != n.getModelsStatus,
      builder: (context, state) {
        if (state.getModelsStatus.isInitial) {
          context.read<ModelsBloc>().add(GetModels());
        }
        if (state.getModelsStatus.isInProgress) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        if (state.getModelsStatus.isSuccess) {
          return BlocBuilder<AddCarBloc, AddCarState>(
            buildWhen: (o, n) => o.temporaryModel != n.temporaryModel,
            builder: (context, addCarState) {
              return Paginator(
                physics: const BouncingScrollPhysics(),
                separatorBuilder: (context, index) {
                  return Builder(builder: (ctx) {
                    if (index + 1 < state.models.length) {
                      return Divider(
                        height: 0,
                        thickness: 1,
                        color: context.theme.dividerColor,
                        indent: 16,
                      );
                    }
                    return const SizedBox();
                  });
                },
                itemBuilder: (context, index) {
                  final model = state.models[index];
                  if (model.id == 0) {
                    return CustomModelItem(
                      title: model.name,
                      onTap: () {
                        context.read<AddCarBloc>().add(SetTemporaryModel(const IdNameEntity(id: 0)));
                      },
                      groupValue: addCarState.temporaryModel.id,
                      value: model.id,
                      customModel: addCarState.otherModel,
                      onChanged: (String value) {
                        context.read<AddCarBloc>().add(SetOtherModel(value));
                      },
                    );
                  }
                  return ModelItem(
                    title: model.name,
                    onTap: () {
                      context.read<AddCarBloc>().add(SetTemporaryModel(model));
                    },
                    groupValue: addCarState.temporaryModel.id,
                    value: model.id,
                  );
                },
                itemCount: state.models.length,
                paginatorStatus: state.getModelsStatus,
                fetchMoreFunction: () {},
                hasMoreToFetch: false,
                errorWidget: const SizedBox.shrink(),
                padding: EdgeInsets.only(bottom: context.padding.bottom + 16),
              );
            },
          );
        }
        if (state.getModelsStatus.isFailure) {
          return const ErrorStateTextWidget();
        }
        return const Spacer();
      },
    );
  }
}
