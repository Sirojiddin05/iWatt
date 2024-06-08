import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/features/profile/presentation/blocs/payments_bloc/payments_bloc.dart';
import 'package:i_watt_app/features/profile/presentation/widgets/radio_card_item.dart';
import 'package:k_watt_app/features/menu/balance/presentation/widgets/radio_card_item.dart';
import 'package:k_watt_app/features/menu/menu/presentation/bloc/payments_bloc/payments_bloc.dart';
import 'package:k_watt_app/utils/extensions.dart';

class PaymentSystems extends StatefulWidget {
  const PaymentSystems({super.key});

  @override
  State<PaymentSystems> createState() => _PaymentSystemsState();
}

class _PaymentSystemsState extends State<PaymentSystems> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentBloc, PaymentState>(
      builder: (context, state) {
        if (state.getPaymentSystemsStatus.isInitial) {
          context.read<PaymentBloc>().add(const GetAvailablePaymentSystemsEvent());
        }
        if (state.getPaymentSystemsStatus.isInProgress) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Wrap(
            runSpacing: 12,
            spacing: 12,
            children: List.generate(state.paymentSystems.length, (index) {
              final payment = state.paymentSystems[index];
              return SizedBox(
                width: (context.sizeOf.width - 44) / 2,
                child: RadioCardItem(
                  onTap: (paymentTitle) => context.read<PaymentBloc>().add(SelectPaymentSystem(paymentTitle)),
                  value: payment.title,
                  groupValue: state.selectedSystemTitle,
                  isDisable: !payment.status,
                  icon: 'assets/images/${payment.title}.png',
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
