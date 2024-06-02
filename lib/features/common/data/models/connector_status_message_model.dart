import 'package:i_watt_app/features/common/domain/entities/connector_status_message.dart';
import 'package:json_annotation/json_annotation.dart';

part 'connector_status_message_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ConnectorStatusMessageModel extends ConnectorStatusMessageEntity {
  const ConnectorStatusMessageModel({
    super.connectorId,
    super.status,
  });

  factory ConnectorStatusMessageModel.fromJson(Map<String, dynamic> json) => _$ConnectorStatusMessageModelFromJson(json);
}
