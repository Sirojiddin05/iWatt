import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_icons.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/my_functions.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/info_container.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/credit_cards_bloc/credit_cards_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/payments_bloc/payments_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/credit_card_item.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

showPayWithCardSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const PayWithCardSheet(),
  );
}

class PayWithCardSheet extends StatefulWidget {
  const PayWithCardSheet({super.key});

  @override
  State<PayWithCardSheet> createState() => _PayWithCardSheetState();
}

class _PayWithCardSheetState extends State<PayWithCardSheet> {
  late final PaymentBloc paymentsBloc;

  @override
  void initState() {
    super.initState();
    paymentsBloc = BlocProvider.of<PaymentBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardsBloc, CreditCardsState>(
      buildWhen: (previous, current) => previous.creditCards != current.creditCards || previous.getCreditCardsStatus != current.getCreditCardsStatus,
      builder: (context, creditCards) {
        return SheetWrapper(
          margin: EdgeInsets.only(top: MediaQueryData.fromView(View.of(context)).padding.top),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SheetHeaderWidget(
                title: LocaleKeys.payment.tr(),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                    child: BlocBuilder<PaymentBloc, PaymentState>(
                      buildWhen: (p, c) => p.selectUserCardId != c.selectUserCardId,
                      builder: (context, paymentState) {
                        return Column(
                          children: [
                            if (creditCards.getCreditCardsStatus.isInProgress) ...{
                              const Padding(
                                padding: EdgeInsets.all(32),
                                child: Center(
                                  child: CircularProgressIndicator.adaptive(),
                                ),
                              )
                            } else if (creditCards.getCreditCardsStatus.isSuccess) ...{
                              if (creditCards.creditCards.isNotEmpty) ...{
                                ...List.generate(creditCards.creditCards.length, (index) {
                                  final card = creditCards.creditCards[index];
                                  return CreditCardItem(
                                    card: card,
                                    editing: true,
                                    selectedId: paymentState.selectUserCardId,
                                    onTap: () {
                                      paymentsBloc.add(SelectUserCardEvent(id: card.id));
                                    },
                                  );
                                }),
                              } else ...{
                                Center(
                                  child: EmptyStateWidget(
                                    icon: AppImages.creditCards,
                                    title: LocaleKeys.you_dont_have_a_card.tr(),
                                    subtitle: LocaleKeys.add_your_card_to_make_payment.tr(),
                                  ),
                                )
                              },
                            } else if (creditCards.getCreditCardsStatus.isFailure) ...{
                              Padding(
                                padding: const EdgeInsets.all(32),
                                child: Center(
                                  child: Text(
                                    LocaleKeys.failure_in_loading.tr(),
                                  ),
                                ),
                              )
                            },
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
              BlocBuilder<ProfileBloc, ProfileState>(
                builder: (context, state) {
                  return InfoContainer(
                    margin: const EdgeInsets.fromLTRB(16, 6, 16, 36),
                    color: AppColors.amaranth.withOpacity(0.1),
                    icon: AppIcons.debtIcon,
                    title: LocaleKeys.you_have_debt_of_amount.tr(),
                    titleTextStyle: context.textTheme.labelMedium?.copyWith(color: AppColors.cyprus),
                    infoText: '${MyFunctions.getBalanceMessage(state.user.balance)} UZS',
                    infoTextStyle: context.textTheme.headlineMedium?.copyWith(color: AppColors.amaranth),
                  );
                },
              ),
              BlocConsumer<PaymentBloc, PaymentState>(
                listenWhen: (p, c) => p.payWithCardStatus != c.payWithCardStatus,
                listener: (context, paymentState) {
                  if (paymentState.payWithCardStatus.isFailure) {
                    context.showPopUp(context, PopUpStatus.failure, message: paymentState.payWithCardError);
                  } else if (paymentState.payWithCardStatus.isSuccess) {
                    Navigator.pop(context);
                    context.read<ProfileBloc>().add(GetUserData());
                    context.showPopUp(context, PopUpStatus.success, message: LocaleKeys.top_up_was_successful.tr());
                  }
                },
                builder: (context, state) {
                  return WButton(
                    text: LocaleKeys.pay.tr(),
                    isLoading: state.payWithCardStatus.isInProgress,
                    isDisabled: state.selectUserCardId == -1,
                    margin: EdgeInsets.fromLTRB(16, 0, 16, 12 + context.padding.bottom),
                    onTap: () {
                      final amount = context.read<ProfileBloc>().state.user.balance.replaceAll('-', ' ');
                      print('on amount: $amount');
                      paymentsBloc.add(PayWithCard(amount: amount));
                    },
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
