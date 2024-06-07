import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/credit_cards_bloc/credit_cards_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/credit_card_item.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/pay_with_card_sheet_bottom.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/pay_with_card_sheet_header.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/remove_credit_card_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

showPayWithCardSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    builder: (context) => const PayWithCardSheet(),
  );
}

class PayWithCardSheet extends StatefulWidget {
  const PayWithCardSheet({super.key});

  @override
  State<PayWithCardSheet> createState() => _PayWithCardSheetState();
}

class _PayWithCardSheetState extends State<PayWithCardSheet> {
  bool editing = false;
  int? selectedId;
  List<int> ids = [];

  @override
  void initState() {
    super.initState();
    // selectedId = cards.first.id;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardsBloc, CreditCardsState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              PayWithCardSheetHeader(
                hasCards: state.creditCards.isNotEmpty,
                onEditTap: () => setState(() => editing = !editing),
              ),
              Flexible(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                    child: Column(
                      children: [
                        if (state.creditCards.isNotEmpty)
                          ...(state.creditCards.map(
                            (e) => CreditCardItem(
                              card: e,
                              editing: editing,
                              selectedId: selectedId,
                              selected: ids.contains(e.id),
                              onTap: !editing
                                  ? () => setState(() => selectedId = e.id)
                                  : () {
                                      setState(() {
                                        if (ids.contains(e.id)) {
                                          ids = [...ids.where((id) => id != e.id)];
                                        } else {
                                          ids = [...ids, e.id];
                                        }
                                      });
                                    },
                            ),
                          ))
                        else
                          EmptyStateWidget(
                            icon: AppImages.creditCards,
                            title: LocaleKeys.you_dont_have_a_card.tr(),
                            subtitle: LocaleKeys.add_your_card_to_make_payment.tr(),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 6),
                child: AnimatedCrossFade(
                  duration: const Duration(milliseconds: 150),
                  crossFadeState: editing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                  alignment: Alignment.bottomCenter,
                  firstChild: const PayWithCardSheetBottom(),
                  secondChild: RemoveCreditCardButton(
                    onCancel: () {
                      selectedId = null;
                    },
                    isLoading: state.deleteCardStatus == FormzSubmissionStatus.inProgress,
                    isDisabled: false,
                    onRemove: () {
                      // context
                      //     .read<CreditCardsBloc>()
                      //     .add(DeleteCreditCardEvent(ids: ids, onSuccess: () {}, onError: (e) {}));
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
