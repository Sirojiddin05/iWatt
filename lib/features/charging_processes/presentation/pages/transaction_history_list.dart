import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charging_processes/presentation/bloc/transactions_bloc/transaction_history_bloc.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/payment_ckeck_sheet.dart';
import 'package:i_watt_app/features/charging_processes/presentation/widgets/transaction_item_history.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/error_state_text.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
import 'package:i_watt_app/features/list/presentation/widgets/charge_location_cards_loader.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TransactionHistoryList extends StatelessWidget {
  const TransactionHistoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
      buildWhen: (o, n) => o.getTransactionHistoryStatus != n.getTransactionHistoryStatus,
      builder: (context, state) {
        if (state.getTransactionHistoryStatus.isInProgress) {
          return const ChargeLocationCardsLoader();
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
                    context.read<TransactionHistoryBloc>().add(GetSingleTransactionEvent(transaction.transactionId));
                    showCupertinoModalBottomSheet(
                      context: context,
                      barrierColor: AppColors.white,
                      enableDrag: false,
                      isDismissible: false,
                      builder: (ctx) {
                        return BlocProvider.value(
                          value: context.read<TransactionHistoryBloc>(),
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
