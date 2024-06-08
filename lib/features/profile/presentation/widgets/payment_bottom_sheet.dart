// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:formz/formz.dart';
// import 'package:i_watt_app/core/config/app_colors.dart';
// import 'package:i_watt_app/core/util/enums/payment_type_enum.dart';
// import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
// import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/thousands_text_editing_formatters.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/w_textfield.dart';
// import 'package:i_watt_app/features/profile/presentation/blocs/payments_bloc/payments_bloc.dart';
// import 'package:i_watt_app/features/profile/presentation/widgets/balance_info_item.dart';
// import 'package:i_watt_app/features/profile/presentation/widgets/cards_list.dart';
// import 'package:i_watt_app/features/profile/presentation/widgets/payment_in_progress.dart';
// import 'package:i_watt_app/features/profile/presentation/widgets/top_body_wrapper.dart';
// import 'package:i_watt_app/generated/locale_keys.g.dart';
// import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
//
// class TopUpBottomSheet extends StatefulWidget {
//   const TopUpBottomSheet({super.key});
//
//   @override
//   State<TopUpBottomSheet> createState() => _TopUpBottomSheetState();
// }
//
// class _TopUpBottomSheetState extends State<TopUpBottomSheet> with WidgetsBindingObserver, TickerProviderStateMixin {
//   late final TextEditingController summController;
//   late final TabController tabController;
//   late final ValueNotifier<int> tabIndexNotifier;
//   late final PaymentBloc paymentsBloc;
//   bool isLoad = false;
//
//   @override
//   void initState() {
//     super.initState();
//     paymentsBloc = PaymentBloc();
//     WidgetsBinding.instance.addObserver(this);
//     tabIndexNotifier = ValueNotifier<int>(0);
//     tabController = TabController(length: 2, vsync: this)
//       ..addListener(() {
//         final index = tabController.index;
//         paymentsBloc.add(SavePaymentTypeEvent(PaymentType.values[index]));
//       });
//     summController = TextEditingController()
//       ..addListener(() {
//         final value = summController.text;
//         paymentsBloc.add(SavePaymentSumEvent(int.tryParse(value.replaceAll(" ", "")) ?? 0));
//       });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WKeyboardDismisser(
//       child: BlocProvider(
//         create: (context) => paymentsBloc,
//         child: BlocListener<PaymentBloc, PaymentState>(
//           listenWhen: (o, n) {
//             final condition = (o.transactionState != n.transactionState) && o.transactionState.isInitial;
//             return condition;
//           },
//           listener: (context, state) {
//             if (state.transactionState.isInProgress) {
//               showCupertinoModalBottomSheet(
//                 context: context,
//                 useRootNavigator: true,
//                 isDismissible: false,
//                 enableDrag: false,
//                 builder: (context) {
//                   return BlocProvider.value(
//                     value: paymentsBloc,
//                     child: PaymentStatusBottomSheet(paymentSystem: state.selectedSystemTitle),
//                   );
//                 },
//               );
//             }
//           },
//           child: Scaffold(
//             backgroundColor: AppColors.white,
//             appBar: AppBar(
//               elevation: 0,
//               leadingWidth: 0,
//               centerTitle: false,
//               backgroundColor: AppColors.white,
//               title: Text(
//                 LocaleKeys.top_up.tr(),
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleSmall!
//                     .copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: dark),
//               ),
//               actions: [
//                 WScaleAnimation(
//                     onTap: () => Navigator.pop(context),
//                     child: Padding(padding: const EdgeInsets.all(8.0), child: SvgPicture.asset(AppIcons.cancel))),
//                 const SizedBox(width: 16)
//               ],
//               bottom: const PreferredSize(
//                 preferredSize: Size.fromHeight(0),
//                 child: Divider(height: 0, thickness: 1, color: AppColors.white),
//               ),
//             ),
//             body: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 12),
//                 const BalanceInfoItem(isMain: false),
//                 Expanded(
//                   child: TopUpBodyWrapper(
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: const EdgeInsets.fromLTRB(16, 0, 16, 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Text(
//                                 LocaleKeys.summa.tr(),
//                                 style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w500),
//                               ),
//                               // BlocBuilder<LoginBloc, LoginState>(
//                               //   buildWhen: (o, n) => o.userEntity.minAmount != n.userEntity.minAmount,
//                               //   builder: (context, state) {
//                               //     final minSum = state.userEntity.minAmount.toInt().toString();
//                               //     return MinSumContainer(
//                               //       onTap: () => setState(() => summController.text = MyFunctions.formatNumber(minSum)),
//                               //       minSum: MyFunctions.formatNumber(minSum),
//                               //     );
//                               //   },
//                               // )
//                             ],
//                           ),
//                         ),
//                         WTextField(
//                           controller: summController,
//                           onChanged: (value) {},
//                           enabledBorderColor: AppColors.white.withOpacity(.4),
//                           cursorColor: AppColors.white,
//                           focusColor: AppColors.white,
//                           textInputFormatters: [
//                             FilteringTextInputFormatter.digitsOnly,
//                             const ThousandsSeparatorInputFormatter(maxCharacterNumber: 7)
//                           ],
//                           borderColor: AppColors.white,
//                           keyBoardType: TextInputType.number,
//                           margin: const EdgeInsets.fromLTRB(16, 0, 16, 20),
//                           textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w400),
//                           titleTextStyle:
//                               Theme.of(context).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w400),
//                           hintText: LocaleKeys.enter_your_top_up.tr(),
//                           hintTextStyle: Theme.of(context)
//                               .textTheme
//                               .titleSmall!
//                               .copyWith(fontWeight: FontWeight.w500, fontSize: 14, color: gullGrey),
//                         ),
//                         CardsList(),
//                       ],
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             bottomNavigationBar: ColoredBox(
//               color: AppColors.white,
//               child: BlocBuilder<PaymentBloc, PaymentState>(
//                 builder: (context, paymentState) {
//                   return WButton(
//                     isLoading: paymentState.getTransactionLinkStatus.isInProgress ||
//                         paymentState.payWithCardStatus.isInProgress,
//                     margin: EdgeInsets.fromLTRB(16, 0, 16,
//                         MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom + 16),
//                     onTap: () async {
//                       if (paymentState.selectedPaymentType.isViaPaymentSystem) {
//                         paymentsBloc.add(GetTransactionLinkEvent(
//                           onError: (String value) {
//                             context.showPopUp(
//                               context,
//                               PopUpStatus.failure,
//                               message: value,
//                             );
//                           },
//                         ));
//                       }
//                       if (paymentState.selectedPaymentType.isViaCard) {
//                         paymentsBloc.add(PayWithCard(onError: (String value) {
//                           context.showPopUp(context, PopUpStatus.failure, message: value);
//                         }, onSuccess: () {
//                           context.read<LoginBloc>().add(GetUserDataEvent());
//                           Navigator.pop(context);
//                           context.showPopUp(
//                               status: PopUpStatus.success,
//                               context: context,
//                               message: LocaleKeys.payment_was_saccessful.tr());
//                         }));
//                       }
//                     },
//                     isDisabled: isButtonDisabled(paymentState),
//                     loadingWidget: const CupertinoActivityIndicator(color: white),
//                     disabledColor: geyser.withOpacity(0.4),
//                     text: LocaleKeys.top_up.tr(),
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     summController.dispose();
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   bool isButtonDisabled(PaymentState state) {
//     if (state.amount <= 0) {
//       return true;
//     }
//     if (state.selectedPaymentType.isViaPaymentSystem && state.selectedSystemTitle.isEmpty) {
//       return true;
//     }
//     if (state.selectedPaymentType.isViaCard && state.selectUserCardId == -1) {
//       return true;
//     }
//     return false;
//   }
// }
