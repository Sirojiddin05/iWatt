import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charging_processes/presentation/bloc/charging_process_bloc/charging_process_bloc.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/charging_car_data_component.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/single_process.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/error_state_text.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

class ChargingProcessList extends StatelessWidget {
  const ChargingProcessList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChargingProcessBloc, ChargingProcessState>(
      builder: (ctx, state) {
        if (state.getChargingProcesses.isInProgress) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        } else if (state.getChargingProcesses.isSuccess) {
          if (state.processes.isEmpty) {
            return RefreshIndicator(
              backgroundColor: context.colorScheme.primaryContainer,
              onRefresh: () async {
                context.read<ChargingProcessBloc>().add(GetChargingProcessesEvent());
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: SizedBox(
                  height: context.sizeOf.height - kToolbarHeight - context.padding.bottom,
                  child: Center(
                    child: EmptyStateWidget(
                      icon: AppImages.carIwatt,
                      title: LocaleKeys.no_charging_cars.tr(),
                      titleTextStyle: Theme.of(context).textTheme.displayLarge,
                      subtitle: LocaleKeys.connect_to_charging_station.tr(),
                      subtitleTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(fontSize: 12),
                    ),
                  ),
                ),
              ),
            );
          }
          if (state.processes.length == 1) {
            final process = state.processes.first;
            return SingleProcess(
              connector: process.connector,
              locationName: process.locationName,
            );
          }
          if (state.processes.isNotEmpty) {
            return ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: state.processes.length,
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 58),
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final process = state.processes[index];
                return /**/ ChargingCarDataWidget(process: process);
              },
            );
          }
        } else if (state.getChargingProcesses.isFailure) {
          return const ErrorStateTextWidget();
        }
        return const SizedBox();
      },
    );
  }
}
