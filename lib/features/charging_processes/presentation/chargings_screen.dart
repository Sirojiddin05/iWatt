import 'package:flutter/material.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/chargers_tab.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/chargings_list.dart';
import 'package:i_watt_app/features/common/presentation/widgets/app_bar_wrapper.dart';

class ChargingProcessesScreen extends StatefulWidget {
  const ChargingProcessesScreen({super.key});

  @override
  State<ChargingProcessesScreen> createState() => _ChargingProcessesScreenState();
}

class _ChargingProcessesScreenState extends State<ChargingProcessesScreen> with SingleTickerProviderStateMixin {
  late TabController tabController;
  // late TransactionsBloc transactionsBloc;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    // transactionsBloc = TransactionsBloc()..add(GetTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
