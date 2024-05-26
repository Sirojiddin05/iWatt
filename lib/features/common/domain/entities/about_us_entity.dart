import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/common/data/models/about_data_model.dart';
import 'package:json_annotation/json_annotation.dart';

class AboutUsEntity extends Equatable {
  final String title;
  final String description;
  final String phone;
  final String email;
  final String botUsername;

  const AboutUsEntity({
    this.phone = "",
    this.email = "",
    this.botUsername = "",
    this.description = "",
    this.title = "",
  });

  @override
  List<Object?> get props => [
        phone,
        description,
        title,
      ];
}

class AboutUsConverter<S> implements JsonConverter<AboutUsEntity, Map<String, dynamic>?> {
  const AboutUsConverter();

  @override
  AboutUsModel fromJson(Map<String, dynamic>? json) => AboutUsModel.fromJson(json ?? {});

  @override
  Map<String, dynamic> toJson(AboutUsEntity object) => AboutUsModel(
        botUsername: object.botUsername,
        email: object.email,
        title: object.title,
        description: object.description,
        phone: object.phone,
      ).toJson();
}
