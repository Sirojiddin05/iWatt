import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charging_processes/data/repositories_impl/transaction_history_repository_impl.dart';
import 'package:i_watt_app/features/charging_processes/domain/usecases/get_single_transaction_usecase.dart';
import 'package:i_watt_app/features/charging_processes/presentation/bloc/transactions_bloc/transaction_history_bloc.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/payment_ckeck_sheet.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/transaction_history_loader.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/transaction_item_history.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/error_state_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:i_watt_app/service_locator.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
      builder: (context, state) {
        if (state.getTransactionHistoryStatus.isInProgress) {
          return const TransactionHistoryLoader();
        } else if (state.getTransactionHistoryStatus.isSuccess) {
          if (state.transactionHistory.isEmpty) {
            return Center(
              child: EmptyStateWidget(
                title: LocaleKeys.there_are_not_stations.tr(),
                subtitle: LocaleKeys.there_is_nothing_here_yet.tr(),
                icon: AppImages.emptyStation,
              ),
            );
          }
          final itemNumber = state.transactionHistory.length;
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(const Duration(milliseconds: 200));
              context.read<TransactionHistoryBloc>().add(GetTransactionHistoryEvent());
            },
            child: Paginator(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.fromLTRB(16, 16, 16, context.padding.bottom),
              paginatorStatus: FormzSubmissionStatus.success,
              itemCount: itemNumber,
              fetchMoreFunction: () {
                context.read<TransactionHistoryBloc>().add(GetMoreTransactionHistory());
              },
              hasMoreToFetch: state.fetchMore,
              itemBuilder: (ctx, index) {
                final transaction = state.transactionHistory[index];
                return TransactionHistoryItem(
                  transaction: transaction,
                  onTap: () {
                    showCupertinoModalBottomSheet(
                      context: context,
                      enableDrag: false,
                      isDismissible: false,
                      useRootNavigator: true,
                      overlayStyle: SystemUiOverlayStyle.dark.copyWith(
                        systemNavigationBarColor: context.theme.scaffoldBackgroundColor,
                        statusBarIconBrightness: Brightness.light,
                        statusBarBrightness: Brightness.dark,
                      ),
                      builder: (ctx) {
                        return BlocProvider(
                          create: (ctx) => TransactionHistoryBloc.single(
                            GetSingleTransactionUseCase(
                              serviceLocator<TransactionHistoryRepositoryImpl>(),
                            ),
                          )..add(GetSingleTransactionEvent(transaction.id)),
                          child: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
                            builder: (context, state) {
                              return ChargingPaymentCheck(
                                cheque: state.singleTransactionHistory,
                                isLoading: state.getSingleTransactionHistoryStatus.isInProgress,
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                );
              },
              separatorBuilder: (ctx, index) => const SizedBox(height: 12),
            ),
          );
        } else if (state.getTransactionHistoryStatus.isFailure) {
          return const ErrorStateTextWidget();
        }
        return const SizedBox.shrink();
      },
    );
  }
}
