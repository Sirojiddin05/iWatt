import 'package:i_watt_app/features/map/domain/entities/cluste_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cluster_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class ClusterModel extends ClusterEntity {
  const ClusterModel({
    super.avgLatitude,
    super.avgLongitude,
    super.id,
    super.quadkey,
    super.count,
  });
  factory ClusterModel.fromJson(Map<String, dynamic> json) => _$ClusterModelFromJson(json);
}
