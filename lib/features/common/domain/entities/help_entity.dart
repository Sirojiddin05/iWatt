import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/common/data/models/help_model.dart';
import 'package:json_annotation/json_annotation.dart';

class HelpEntity extends Equatable {
  final String helpTelegramLink;
  final String helpEmail;
  final String helpPhoneNumber;

  const HelpEntity({
    this.helpEmail = '',
    this.helpPhoneNumber = '',
    this.helpTelegramLink = '',
  });

  @override
  List<Object?> get props => [
        helpPhoneNumber,
        helpEmail,
        helpTelegramLink,
      ];
}

class HelpConverter<S> implements JsonConverter<HelpEntity, Map<String, dynamic>?> {
  const HelpConverter();

  @override
  HelpModel fromJson(Map<String, dynamic>? json) => HelpModel.fromJson(json ?? {});

  @override
  Map<String, dynamic> toJson(HelpEntity object) => HelpModel(
        helpPhoneNumber: object.helpPhoneNumber,
        helpEmail: object.helpEmail,
        helpTelegramLink: object.helpTelegramLink,
      ).toJson();
}
