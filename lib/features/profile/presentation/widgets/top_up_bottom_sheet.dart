import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/core/util/text_formatters/thousands_text_editing_formatters.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/present_sheet_header.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/credit_cards_bloc/credit_cards_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/payments_bloc/payments_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/profile_bloc/profile_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/add_card_bottom_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/add_card_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/balance_message.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/credit_card_item.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class TopUpBottomSheet extends StatefulWidget {
  const TopUpBottomSheet({super.key});

  @override
  State<TopUpBottomSheet> createState() => _TopUpBottomSheetState();
}

class _TopUpBottomSheetState extends State<TopUpBottomSheet> with WidgetsBindingObserver, TickerProviderStateMixin {
  late final TextEditingController amountController;
  late final PaymentBloc paymentsBloc;
  late int selectedCardId;

  @override
  void initState() {
    super.initState();
    paymentsBloc = BlocProvider.of<PaymentBloc>(context);
    selectedCardId = paymentsBloc.state.selectUserCardId;
    amountController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return WKeyboardDismisser(
      child: AnnotatedRegion(
        value: SystemUiOverlayStyle.dark.copyWith(
          systemNavigationBarColor: AppColors.white,
        ),
        child: Scaffold(
          backgroundColor: context.themedColors.whiteToCyprusO8,
          body: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PresentSheetHeader(
                title: LocaleKeys.top_up.tr(),
                isTitleCentered: false,
                onCloseTap: () => Navigator.pop(context),
              ),
              Divider(color: context.theme.dividerColor, height: 1, thickness: 1),
              const SizedBox(height: 16),
              const BalanceMessage(isMain: false),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                        child: DefaultTextField(
                          title: LocaleKeys.input_the_sum.tr(),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            const ThousandsSeparatorInputFormatter(),
                          ],
                          onChanged: (value) {
                            paymentsBloc.add(SavePaymentSumEvent(value.replaceAll(" ", "")));
                          },
                          hintText: '0',
                          keyboardType: TextInputType.number,
                          controller: amountController,
                          suffixMaxWidth: 62,
                          suffix: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Text(
                              "UZS",
                              style: context.textTheme.headlineLarge!.copyWith(color: AppColors.darkGray),
                            ),
                          ),
                        ),
                      ),
                      Divider(color: context.theme.dividerColor, height: 1, thickness: 1),
                      BlocBuilder<CreditCardsBloc, CreditCardsState>(
                        buildWhen: (p, c) =>
                            p.getCreditCardsStatus != c.getCreditCardsStatus || p.creditCards != c.creditCards,
                        builder: (context, creditCards) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(16, 6, 16, 16),
                            child: Column(
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
                                        selectedId: selectedCardId,
                                        onTap: () {
                                          setState(() {
                                            selectedCardId = card.id;
                                          });
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
                                  AddCardButton(
                                    onTap: () {
                                      showCupertinoModalBottomSheet(
                                        context: context,
                                        useRootNavigator: true,
                                        overlayStyle: SystemUiOverlayStyle.dark.copyWith(
                                          statusBarIconBrightness: Brightness.light,
                                          statusBarBrightness: Brightness.dark,
                                          systemNavigationBarColor: AppColors.white,
                                        ),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                                        ),
                                        builder: (context) => const AddCardBottomSheet(),
                                      );
                                    },
                                  )
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
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          bottomNavigationBar: BlocConsumer<PaymentBloc, PaymentState>(
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
            builder: (context, paymentState) {
              return WButton(
                text: LocaleKeys.top_up.tr(),
                isLoading: paymentState.payWithCardStatus.isInProgress,
                margin: EdgeInsets.fromLTRB(16, 0, 16, context.padding.bottom + context.viewInsets.bottom + 16),
                isDisabled: paymentState.amount.isEmpty || paymentState.selectUserCardId == -1,
                onTap: () async {
                  paymentsBloc.add(const PayWithCard());
                },
              );
            },
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}
