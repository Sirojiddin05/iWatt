import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/config/app_images.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/common/presentation/widgets/empty_state_widget.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/credit_cards_bloc/credit_cards_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/add_card_bottom_sheet.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/add_card_button.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/credit_card_item.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/my_cards_sheet_header.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/remove_credit_card_button.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

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
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreditCardsBloc, CreditCardsState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            MyCardsSheetHeader(
              editing: editing,
              hasCards: state.creditCards.isNotEmpty,
              onEditTap: () => setState(() {
                editing = !editing;
                if (selectedId != null) {
                  selectedId = null;
                } else {
                  selectedId = 0;
                }
              }),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
              child: Column(
                children: [
                  if (state.getCreditCardsStatus.isInProgress) ...{
                    const Padding(
                      padding: EdgeInsets.all(32),
                      child: Center(
                        child: CircularProgressIndicator.adaptive(),
                      ),
                    )
                  } else if (state.getCreditCardsStatus.isSuccess) ...{
                    if (state.creditCards.isNotEmpty) ...{
                      ...List.generate(state.creditCards.length, (index) {
                        final card = state.creditCards[index];
                        return CreditCardItem(
                          card: card,
                          editing: editing,
                          selectedId: selectedId,
                          onTap: !editing
                              ? () {}
                              : () {
                                  setState(() {
                                    selectedId = card.id;
                                  });
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
                    AnimatedCrossFade(
                      duration: const Duration(milliseconds: 150),
                      crossFadeState: editing ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                      alignment: Alignment.bottomCenter,
                      firstChild: AddCardButton(
                        onTap: () {
                          Navigator.pop(context);
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
                      ),
                      secondChild: RemoveCreditCardButton(
                        onCancel: () {
                          setState(() {
                            selectedId = null;
                            editing = false;
                          });
                        },
                        isLoading: state.deleteCardStatus == FormzSubmissionStatus.inProgress,
                        isDisabled: selectedId == null || selectedId == 0,
                        onRemove: () {
                          if (selectedId != null && selectedId != 0) {
                            context.read<CreditCardsBloc>().add(
                                  DeleteCreditCardEvent(
                                    id: selectedId!,
                                    onSuccess: () {
                                      setState(() {
                                        selectedId = null;
                                        editing = false;
                                      });
                                    },
                                    onError: (e) {
                                      context.showPopUp(
                                        context,
                                        PopUpStatus.failure,
                                        message: e,
                                      );
                                    },
                                  ),
                                );
                          }
                        },
                      ),
                    ),
                  } else if (state.getCreditCardsStatus.isFailure) ...{
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: Center(
                        child: Text(
                          LocaleKeys.failure_in_loading.tr(),
                        ),
                      ),
                    )
                  },
                  SizedBox(height: context.padding.bottom + 12),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
