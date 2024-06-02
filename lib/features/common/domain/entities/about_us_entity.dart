import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/common/data/models/about_us_model.dart';
import 'package:json_annotation/json_annotation.dart';

class AboutUsEntity extends Equatable {
  final String title;
  final String content;

  const AboutUsEntity({
    this.title = '',
    this.content = '',
  });

  @override
  List<Object?> get props => [title, content];
}

class HelpConverter<S> implements JsonConverter<AboutUsEntity, Map<String, dynamic>?> {
  const HelpConverter();

  @override
  AboutUsModel fromJson(Map<String, dynamic>? json) => AboutUsModel.fromJson(json ?? {});

  @override
  Map<String, dynamic> toJson(AboutUsEntity object) => AboutUsModel(
        title: object.title,
        content: object.content,
      ).toJson();
}
