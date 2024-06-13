// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:i_watt_app/core/config/app_colors.dart';
// import 'package:i_watt_app/core/config/app_icons.dart';
// import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/option_container.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/sheet_wrapper.dart';
// import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
// import 'package:i_watt_app/features/profile/domain/entities/car_entity.dart';
// import 'package:i_watt_app/features/profile/presentation/blocs/edit_car_bloc/edit_car_bloc.dart';
// import 'package:i_watt_app/features/profile/presentation/widgets/car_number_textfield.dart';
// import 'package:i_watt_app/features/profile/presentation/widgets/edit_manufacturers_list.dart';
// import 'package:i_watt_app/generated/locale_keys.g.dart';
//
// class EditCarSheet extends StatefulWidget {
//   final CarEntity car;
//   const EditCarSheet({super.key, required this.car});
//
//   @override
//   State<EditCarSheet> createState() => _EditCarSheetState();
// }
//
// class _EditCarSheetState extends State<EditCarSheet> {
//   late final EditCarBloc editCarBloc;
//   late final TextEditingController regionTextEditingController;
//   late final TextEditingController numberTextEditingController;
//
//   @override
//   void initState() {
//     super.initState();
//     editCarBloc = EditCarBloc();
//     regionTextEditingController = TextEditingController();
//     numberTextEditingController = TextEditingController();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider.value(
//       value: editCarBloc,
//       child: Padding(
//         padding: EdgeInsets.only(top: MediaQueryData.fromView(View.of(context)).padding.top),
//         child: SheetWrapper(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               SheetHeaderWidget(
//                 title: LocaleKeys.edit_car.tr(),
//               ),
//               Flexible(
//                 child: SingleChildScrollView(
//                   child: Padding(
//                     padding: const EdgeInsets.all(16),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         BlocBuilder<EditCarBloc, EditCarState>(
//                           buildWhen: (o, n) {
//                             final isManufacturerChanged = o.car.manufacturer != n.car.manufacturer;
//                             final isCustomManufacturerChanged = o.car.manufacturer != n.car.manufacturer;
//                             return isManufacturerChanged || isCustomManufacturerChanged;
//                           },
//                           builder: (context, state) {
//                             return OptionContainer(
//                               title: LocaleKeys.brand_capital.tr(),
//                               content: Text(
//                                 state.car.manufacturer,
//                                 style: context.textTheme.titleLarge?.copyWith(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               icon: AppIcons.chevronDown,
//                               onTap: () {
//                                 showModalBottomSheet(
//                                   context: context,
//                                   builder: (ctx) {
//                                     return const EditManufacturersList();
//                                   },
//                                 );
//                               },
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 24),
//                         BlocBuilder<EditCarBloc, EditCarState>(
//                           buildWhen: (o, n) {
//                             final isModelChanged = o.car.model != n.car.model;
//                             return isModelChanged;
//                           },
//                           builder: (context, state) {
//                             return OptionContainer(
//                               title: LocaleKeys.model_capital.tr(),
//                               content: Text(
//                                 state.car.model,
//                                 style: context.textTheme.titleLarge?.copyWith(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               icon: AppIcons.chevronDown,
//                               onTap: () {
//                                 // showModalBottomSheet(
//                                 //   context: context,
//                                 //   builder: (ctx) {},
//                                 // );
//                               },
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 24),
//                         BlocBuilder<EditCarBloc, EditCarState>(
//                           buildWhen: (o, n) {
//                             final isModelChanged = o.car.connectorType != n.car.connectorType;
//                             return isModelChanged;
//                           },
//                           builder: (context, state) {
//                             return OptionContainer(
//                               title: LocaleKeys.connector_types.tr(),
//                               content: Text(
//                                 state.car.model,
//                                 style: context.textTheme.titleLarge?.copyWith(
//                                   fontSize: 16,
//                                 ),
//                               ),
//                               icon: AppIcons.chevronDown,
//                               onTap: () {
//                                 // showModalBottomSheet(
//                                 //   context: context,
//                                 //   builder: (ctx) {},
//                                 // );
//                               },
//                             );
//                           },
//                         ),
//                         const SizedBox(height: 24),
//                         Text(
//                           LocaleKeys.government_number_of_car.tr(),
//                           style: context.textTheme.titleMedium?.copyWith(
//                             fontSize: 12,
//                             color: AppColors.darkGray,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         CarNumberField(
//                           requestFocusInitially: false,
//                           regionTextEditingController: regionTextEditingController,
//                           numberTextEditingController: numberTextEditingController,
//                           context: context,
//                           numberType: 0,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               WButton(
//                 onTap: () {},
//                 text: LocaleKeys.save.tr(),
//                 margin: EdgeInsets.fromLTRB(
//                   16,
//                   8,
//                   16,
//                   context.viewInsets.bottom + context.padding.bottom + 16,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
