import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/features/charging_processes/data/repositories_impl/transaction_history_repository_impl.dart';
import 'package:i_watt_app/features/charging_processes/domain/usecases/get_single_transaction_usecase.dart';
import 'package:i_watt_app/features/charging_processes/domain/usecases/get_transaction_history_usecase.dart';
import 'package:i_watt_app/features/charging_processes/presentation/bloc/transactions_bloc/transaction_history_bloc.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/chargers_tab.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/chargings_list.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';
import 'package:i_watt_app/service_locator.dart';

class ChargingProcessesScreen extends StatefulWidget {
  const ChargingProcessesScreen({super.key});

  @override
  State<ChargingProcessesScreen> createState() => _ChargingProcessesScreenState();
}

class _ChargingProcessesScreenState extends State<ChargingProcessesScreen> with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final TransactionHistoryBloc transactionsBloc;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    transactionsBloc = TransactionHistoryBloc(
      GetTransactionHistoryUseCase(serviceLocator<TransactionHistoryRepositoryImpl>()),
      GetSingleTransactionUseCase(serviceLocator<TransactionHistoryRepositoryImpl>()),
    )..add(GetTransactionHistoryEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: transactionsBloc,
      child: Scaffold(
        appBar: AppBarWrapper(
          child: ChargersTab(
            tabController: tabController,
          ),
        ),
        body: TabBarView(
          controller: tabController,
          physics: const BouncingScrollPhysics(),
          children: const [
            ChargingProcessList(),
            SizedBox(),
          ],
        ),
      ),
    );
  }
}
