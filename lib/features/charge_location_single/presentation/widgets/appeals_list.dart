import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:i_watt_app/core/config/app_colors.dart';
import 'package:i_watt_app/core/util/enums/pop_up_status.dart';
import 'package:i_watt_app/core/util/extensions/build_context_extension.dart';
import 'package:i_watt_app/features/charge_location_single/data/repository_imlp/appeal_repository_impl.dart';
import 'package:i_watt_app/features/charge_location_single/domain/usecases/get_appeals_usecase.dart';
import 'package:i_watt_app/features/charge_location_single/domain/usecases/send_appeal_usecase.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/blocs/appeal_bloc/appeal_bloc.dart';
import 'package:i_watt_app/features/charge_location_single/presentation/widgets/appeal_make_item.dart';
import 'package:i_watt_app/features/common/presentation/widgets/default_text_field.dart';
import 'package:i_watt_app/features/common/presentation/widgets/paginator.dart';
import 'package:i_watt_app/features/common/presentation/widgets/sheet_header_widget.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_button.dart';
import 'package:i_watt_app/features/common/presentation/widgets/w_keyboard_dismisser.dart';
import 'package:i_watt_app/generated/locale_keys.g.dart';
import 'package:i_watt_app/service_locator.dart';

class AppealsList extends StatefulWidget {
  const AppealsList({super.key, required this.location});
  final int location;

  @override
  State<AppealsList> createState() => _AppealsListState();
}

class _AppealsListState extends State<AppealsList> {
  late TextEditingController appealController;
  late final ValueNotifier<int> appealNotifier;
  late final FocusNode focusNode;
  late final ScrollController controller;
  late final AppealBloc appealBloc;

  @override
  void initState() {
    super.initState();
    appealNotifier = ValueNotifier<int>(0);
    appealBloc = AppealBloc(
      chargerAppealUseCase: SendAppealsUseCase(
        serviceLocator<AppealRepositoryImpl>(),
      ),
      getAppealsUseCase: GetAppealsUseCase(
        serviceLocator<AppealRepositoryImpl>(),
      ),
    )..add(GetAppealsEvent());
    appealController = TextEditingController();
    focusNode = FocusNode();
    controller = ScrollController();
  }

  @override
  void dispose() {
    appealController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: appealBloc,
      child: WKeyboardDismisser(
        child: BlocConsumer<AppealBloc, AppealState>(
          listener: (context, state) {
            if (state.sendAppealStatus.isFailure) {
              context.showPopUp(context, PopUpStatus.failure, message: state.sendErrorMessage);
            } else if (state.sendAppealStatus.isSuccess) {
              Navigator.pop(context);
              context.showPopUp(context, PopUpStatus.success, message: LocaleKeys.appeal_successfully_sent.tr());
            }
          },
          builder: (ctx, state) {
            return Container(
              margin: EdgeInsets.only(
                top: MediaQueryData.fromView(View.of(context)).padding.top,
              ),
              decoration: BoxDecoration(color: context.colorScheme.background, borderRadius: const BorderRadius.vertical(top: Radius.circular(16))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SheetHeaderWidget(
                    title: LocaleKeys.to_complain.tr(),
                  ),
                  Divider(color: context.theme.dividerColor, thickness: 1, height: 1),
                  if (state.getAppealsStatus.isInProgress) ...{
                    Padding(padding: EdgeInsets.fromLTRB(16, 16, 16, context.padding.bottom), child: const CircularProgressIndicator.adaptive())
                  } else if (state.getAppealsStatus.isSuccess) ...{
                    if (state.appeals.isNotEmpty) ...{
                      Flexible(
                        child: Paginator(
                          shrinkWrap: true,
                          controller: controller,
                          physics: const BouncingScrollPhysics(),
                          separatorBuilder: (context, index) => index == state.appeals.length - 1
                              ? const SizedBox.shrink()
                              : Divider(color: context.theme.dividerColor, thickness: 1, height: 1, indent: 48),
                          paginatorStatus: state.getAppealsStatus,
                          itemBuilder: (BuildContext context, int index) {
                            final model = state.appeals[index];
                            return ValueListenableBuilder(
                              valueListenable: appealNotifier,
                              builder: (context, value, child) {
                                if (index == state.appeals.length - 1) {
                                  return Column(
                                    children: [
                                      AppealMakeItem(
                                        appealEntity: model,
                                        value: index,
                                        groupValue: value,
                                        onChanged: (int v) async {
                                          appealNotifier.value = v;
                                          await Future.delayed(const Duration(milliseconds: 150));
                                          FocusScope.of(context).requestFocus(focusNode);
                                        },
                                      ),
                                      AnimatedCrossFade(
                                        firstChild: Material(
                                          child: Container(
                                            color: AppColors.white,
                                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                            child: DefaultTextField(
                                              controller: appealController,
                                              hintText: LocaleKeys.input_appeal_reason.tr(),
                                              onChanged: (v) {
                                                setState(() {});
                                              },
                                              focusNode: focusNode,
                                              height: 84,
                                              maxLines: 3,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(500),
                                              ],
                                              hintStyle: Theme.of(context).textTheme.titleSmall,
                                              onSubmitted: (String value) {},
                                            ),
                                          ),
                                        ),
                                        secondChild: SizedBox(width: MediaQuery.sizeOf(context).width),
                                        crossFadeState: value == state.appeals.length - 1 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                                        duration: const Duration(milliseconds: 150),
                                      ),
                                      const SizedBox(height: 8)
                                    ],
                                  );
                                }
                                return AppealMakeItem(
                                  appealEntity: model,
                                  value: index,
                                  groupValue: value,
                                  onChanged: (int v) async {
                                    appealNotifier.value = v;
                                  },
                                );
                              },
                            );
                          },
                          itemCount: state.appeals.length,
                          fetchMoreFunction: () {
                            ctx.read<AppealBloc>().add(GetMoreAppeals());
                          },
                          hasMoreToFetch: state.fetchMore,
                        ),
                      )
                    }
                  },
                  if (state.appeals.isNotEmpty) ...{
                    ValueListenableBuilder(
                      valueListenable: appealNotifier,
                      builder: (BuildContext context, value, Widget? child) {
                        return WButton(
                          isLoading: state.sendAppealStatus.isInProgress,
                          margin: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                          isDisabled: appealController.text.isEmpty && appealNotifier.value == state.appeals.length - 1,
                          text: LocaleKeys.send.tr(),
                          onTap: () {
                            ctx.read<AppealBloc>().add(
                                  SendAppealEvent(
                                    location: widget.location,
                                    text: appealNotifier.value == state.appeals.length - 1
                                        ? appealController.text
                                        : state.appeals[appealNotifier.value].name,
                                  ),
                                );
                          },
                        );
                      },
                    ),
                  },
                  SizedBox(height: MediaQuery.viewInsetsOf(context).bottom + 16)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
