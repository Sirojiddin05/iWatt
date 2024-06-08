// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:formz/formz.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
// import 'package:i_watt_app/features/profile/presentation/blocs/payments_bloc/payments_bloc.dart';
// import 'package:i_watt_app/features/profile/presentation/widgets/selectable_card_item.dart';
// import 'package:i_watt_app/generated/locale_keys.g.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
//
// class CardsList extends StatelessWidget {
//   const CardsList({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<UserCardsBloc, UserCardsState>(
//       builder: (context, state) {
//         if (state.getUserCardsStatus.isInitial) {
//           context.read<UserCardsBloc>().add(const GetUserCards());
//         }
//         if (state.getUserCardsStatus.isInProgress) {
//           return const Center(child: CircularProgressIndicator.adaptive());
//         }
//         if (state.getUserCardsStatus.isFailure) {
//           return Text(LocaleKeys.error_loading.tr());
//         }
//         if (state.userCards.isEmpty) {
//           return CardEmptyState(onAddCard: () {
//             showCupertinoModalBottomSheet(
//                 context: context,
//                 builder: (context) {
//                   return const ViaCardBottomSheet();
//                 }).then((value) {
//               context.read<UserCardsBloc>().add(const GetUserCards());
//             });
//           });
//         } else {
//           return BlocBuilder<PaymentBloc, PaymentState>(
//             builder: (context, paymentState) {
//               return Paginator(
//                 padding: const EdgeInsets.only(top: 10),
//                 itemBuilder: (context, index) {
//                   if (index == state.userCards.length) {
//                     return AddUserCardButton(
//                       onTap: () {
//                         showCupertinoModalBottomSheet(
//                             context: context,
//                             builder: (context) {
//                               return const ViaCardBottomSheet();
//                             }).then((value) {
//                           context.read<UserCardsBloc>().add(const GetUserCards());
//                         });
//                       },
//                       margin: const EdgeInsets.fromLTRB(16, 4, 16, 0),
//                     );
//                   }
//                   final card = state.userCards[index];
//                   return Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16),
//                     child: SelectableUserCard(
//                       onTap: () {
//                         context.read<PaymentBloc>().add(SelectUserCardEvent(id: card.id));
//                       },
//                       isSelected: card.id == paymentState.selectUserCardId,
//                       number: card.cardNumber,
//                       bankName: card.bankName,
//                     ),
//                   );
//                 },
//                 separatorBuilder: (context, index) => const SizedBox(height: 12),
//                 itemCount: state.userCards.length + 1,
//                 paginatorStatus: state.getUserCardsStatus,
//                 fetchMoreFunction: () => context.read<UserCardsBloc>().add(const GetMoreUserCards()),
//                 hasMoreToFetch: state.userCardsNext.isNotEmpty,
//               );
//             },
//           );
//         }
//       },
//     );
//   }
// }
