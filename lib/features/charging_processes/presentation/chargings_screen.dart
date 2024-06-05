import 'package:flutter/material.dart';

class ChargingProcessesScreen extends StatefulWidget {
  const ChargingProcessesScreen({super.key});

  @override
  State<ChargingProcessesScreen> createState() => _ChargingProcessesScreenState();
}

class _ChargingProcessesScreenState extends State<ChargingProcessesScreen> {
  late TabController tabController;
  // late TransactionsBloc transactionsBloc;
  @override
  void initState() {
    super.initState();
    // tabController = TabController(length: 2, vsync: this);
    // transactionsBloc = TransactionsBloc()..add(GetTransactions());
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox();
    // return BlocProvider.value(
    //   value: transactionsBloc,
    //   child: Scaffold(
    //     appBar: AppBar(
    //       elevation: 1,
    //       shadowColor: baliHai.withOpacity(0.4),
    //       toolbarHeight: 8,
    //       bottom: PreferredSize(
    //         preferredSize: const Size.fromHeight(48),
    //         child: ChargersTab(tabController: tabController),
    //       ),
    //     ),
    //     backgroundColor: lilyWhite1,
    //     body: TabBarView(
    //       controller: tabController,
    //       physics: const BouncingScrollPhysics(),
    //       children: [
    //         ChargingProcessList(),
    //         const ChargeHistoryList(),
    //       ],
    //     ),
    //   ),
    // );
  }
}
