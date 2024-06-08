// import 'dart:io';
//
// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:formz/formz.dart';
// import 'package:i_watt_app/core/config/app_icons.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/w_scale_animation.dart';
// import 'package:i_watt_app/features/profile/presentation/blocs/payments_bloc/payments_bloc.dart';
// import 'package:i_watt_app/generated/locale_keys.g.dart';
// import 'package:url_launcher/url_launcher_string.dart';
//
// class PaymentStatusBottomSheet extends StatefulWidget {
//   final String paymentSystem;
//   const PaymentStatusBottomSheet({super.key, required this.paymentSystem});
//
//   @override
//   State<PaymentStatusBottomSheet> createState() => _PaymentStatusBottomSheetState();
// }
//
// class _PaymentStatusBottomSheetState extends State<PaymentStatusBottomSheet> with WidgetsBindingObserver {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//   }
//
//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) {
//     final paymentBloc = context.read<PaymentBloc>();
//     if (state == AppLifecycleState.resumed) {
//       if (paymentBloc.state.transactionId > 0) {
//         paymentBloc.add(const GetTransactionStateEvent());
//       }
//     }
//     super.didChangeAppLifecycleState(state);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: lilyWhite1,
//       appBar: AppBar(
//         backgroundColor: lilyWhite1,
//         elevation: 0,
//         systemOverlayStyle: SystemUiOverlayStyle(
//           statusBarColor: !Platform.isIOS ? Colors.transparent : Colors.transparent,
//           statusBarIconBrightness: !Platform.isIOS ? Brightness.light : Brightness.dark,
//           statusBarBrightness: !Platform.isIOS ? Brightness.light : Brightness.dark,
//         ),
//         leadingWidth: 0,
//         centerTitle: false,
//         title: Text(
//           LocaleKeys.balance_replenishment.tr(),
//           style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 16, fontWeight: FontWeight.w700, color: dark),
//         ),
//         actions: [
//           BlocBuilder<PaymentBloc, PaymentState>(
//             builder: (context, state) {
//               return WScaleAnimation(
//                   onTap: () {
//                     if (state.transactionState.isSuccess) {
//                       // context.read<LoginBloc>().add(GetUserDataEvent());
//                     }
//                     Navigator.of(context)
//                       ..pop()
//                       ..pop();
//                   },
//                   child: SvgPicture.asset(AppIcons.cancel));
//             },
//           ),
//           const SizedBox(width: 16),
//         ],
//         bottom: const PreferredSize(
//           preferredSize: Size.fromHeight(0),
//           child: Divider(
//             height: 0,
//             thickness: 1,
//             color: geyser,
//           ),
//         ),
//       ),
//       body: BlocBuilder<PaymentBloc, PaymentState>(
//         builder: (context, state) {
//           return SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 const SizedBox(height: 32),
//                 AnimatedSwitcher(duration: const Duration(milliseconds: 200), child: SvgPicture.asset(getStatusIcon(state))),
//                 const SizedBox(height: 16),
//                 Text(
//                   getMainText(state).tr(),
//                   style: Theme.of(context).textTheme.displayLarge!.copyWith(color: mainTextColor),
//                 ),
//                 const SizedBox(height: 2),
//                 Text(
//                   getSubText(state).tr(),
//                   style: Theme.of(context).textTheme.titleSmall!.copyWith(fontSize: 12),
//                 ),
//                 AboutPaymentWidget(
//                   paymentType: widget.paymentSystem,
//                   commission: '-',
//                   date: state.paymentStatusEntity.paidAt,
//                   sum: state.amount.toString(),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//       bottomNavigationBar: BlocBuilder<PaymentBloc, PaymentState>(
//         builder: (context, state) {
//           return Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               WButton(
//                 rippleColor: white.withAlpha(50),
//                 isLoading: state.getTransactionStateStatus.isInProgress,
//                 margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
//                 onTap: () {
//                   if (state.transactionState.isSuccess) {
//                     context.read<LoginBloc>().add(GetUserDataEvent());
//                     Navigator.of(context)
//                       ..pop()
//                       ..pop();
//                   } else {
//                     launchUrlString(state.transactionLink);
//                   }
//                 },
//                 text: state.transactionState.isSuccess ? LocaleKeys.go_back.tr() : LocaleKeys.try_again.tr(),
//                 color: mainButtonColor,
//                 textColor: white,
//               ),
//               if (!state.transactionState.isSuccess)
//                 WButton(
//                   margin: EdgeInsets.fromLTRB(16, 0, 16, MediaQuery.of(context).viewInsets.bottom + MediaQuery.of(context).padding.bottom + 16),
//                   onTap: () {
//                     context.read<LoginBloc>().add(GetUserDataEvent());
//                     Navigator.of(context)
//                       ..pop()
//                       ..pop();
//                   },
//                   rippleColor: mainTextColor.withAlpha(50),
//                   text: LocaleKeys.go_back.tr(),
//                   color: geyser.withOpacity(.4),
//                   textColor: mainTextColor,
//                 ),
//             ],
//           );
//         },
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }
//
//   String getMainText(PaymentState state) {
//     if (state.transactionState.isInProgress) {
//       return LocaleKeys.payment_in_progress.tr();
//     } else if (state.getTransactionStateStatus.isFailure) {
//       return LocaleKeys.payment_failed.tr();
//     } else if (state.getTransactionStateStatus.isSuccess) {
//       return "${MyFunctions.formatNumber(state.amount.toString())} UZS";
//     }
//     return "";
//   }
//
//   String getSubText(PaymentState state) {
//     if (state.transactionState.isInProgress) {
//       return LocaleKeys.waiting_response_from_system.tr();
//     } else if (state.getTransactionStateStatus.isFailure) {
//       return LocaleKeys.payment_is_rejected.tr();
//     } else if (state.getTransactionStateStatus.isSuccess) {
//       return LocaleKeys.payment_was_saccessful.tr();
//     }
//     return "";
//   }
//
//   String getStatusIcon(PaymentState state) {
//     if (state.transactionState.isInProgress) {
//       return AppIcons.paymentInProgress;
//     } else if (state.getTransactionStateStatus.isFailure) {
//       return AppIcons.paymentFailure;
//     } else if (state.getTransactionStateStatus.isSuccess) {
//       return AppIcons.paymentInSuccess;
//     }
//     return "";
//   }
// }
