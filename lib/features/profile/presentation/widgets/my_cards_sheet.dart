import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/credit_cards_bloc/credit_cards_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/add_card_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/credit_card_item.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/my_cards_sheet_header.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/remove_credit_card_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';

showMyCardsSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(12),
      ),
    ),
    builder: (context) => const MyCardsSheet(),
  );
}

class MyCardsSheet extends StatefulWidget {
  const MyCardsSheet({super.key});

  @override
  State<MyCardsSheet> createState() => _MyCardsSheetState();
}

class _MyCardsSheetState extends State<MyCardsSheet> {
  bool editing = false;
  int? selectedIds;

  @override
  void initState() {
    super.initState();
    context.read<CreditCardsBloc>().add(const GetCreditCards());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardsBloc, CreditCardsState>(
      builder: (context, state) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              MyCardsSheetHeader(
                editing: editing,
                hasCards: state.creditCards.isNotEmpty,
                onEditTap: () => setState(() {
                  editing = !editing;
                  if (selectedIds != null) {
                    selectedIds = null;
                  } else {
                    selectedIds = 0;
                  }
                }),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
                child: Column(
                  children: [
                    if (state.creditCards.isNotEmpty)
                      ...(state.creditCards.map(
                        (e) => CreditCardItem(
                          card: e,
                          editing: false,
                          selectedId: selectedIds,
                          onTap: !editing
                              ? () {}
                              : () {
                                  setState(() {
                                    selectedIds = e.id;
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
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 150),
                      crossFadeState: editing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      alignment: Alignment.bottomCenter,
                      firstChild: const AddCardButton(),
                      secondChild: Padding(
                        padding: const EdgeInsets.only(top: 26.0),
                        child: RemoveCreditCardButton(
                          onCancel: () {
                            setState(() {
                              selectedIds = null;
                              editing = false;
                            });
                          },
                          isLoading: state.deleteCardStatus == FormzSubmissionStatus.inProgress,
                          isDisabled: selectedIds == null || selectedIds == 0,
                          onRemove: () {
                            if (selectedIds != null && selectedIds != 0) {
                              context
                                  .read<CreditCardsBloc>()
                                  .add(DeleteCreditCardEvent(id: selectedIds!, onSuccess: () {}, onError: (e) {}));
                            }
                          },
                        ),
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
