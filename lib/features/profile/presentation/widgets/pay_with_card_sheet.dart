import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_watt_app/features/profile/domain/entities/credit_card_entity.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/credit_cards_bloc/credit_cards_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/credit_card_item.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/pay_with_card_sheet_bottom.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/pay_with_card_sheet_header.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/remove_credit_card_button.dart';

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
  List<CreditCardEntity> cards = [
    const CreditCardEntity(
      id: 1,
      cardNumber: '9860 1201 **** 5499',
      expireDate: '09/28',
      balance: 0,
    ),
    const CreditCardEntity(
      id: 2,
      cardNumber: '8600 1201 **** 5499',
      expireDate: '09/28',
      balance: 0,
    ),
    const CreditCardEntity(
      id: 3,
      cardNumber: '5614 1201 **** 5499',
      expireDate: '09/28',
      balance: 0,
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedId = cards.first.id;
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
                onEditTap: () => setState(() => editing = !editing),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                child: Column(
                  children: [
                    ...(cards.map(
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
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 26.0),
                      child: AnimatedCrossFade(
                        duration: const Duration(milliseconds: 150),
                        crossFadeState: editing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                        alignment: Alignment.bottomCenter,
                        firstChild: const PayWithCardSheetBottom(),
                        secondChild: const RemoveCreditCardButton(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
