import 'package:i_watt_app/features/common/domain/entities/search_history_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_history_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class SearchHistoryModel extends SearchHistoryEntity {
  const SearchHistoryModel({
    super.id,
    super.location,
    super.locationId,
    super.locationName,
    super.vendorName,
    super.address,
  });

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) => _$SearchHistoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchHistoryModelToJson(this);
}
