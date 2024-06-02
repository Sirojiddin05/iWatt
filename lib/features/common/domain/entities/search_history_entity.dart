import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/common/data/models/search_history_model.dart';
import 'package:json_annotation/json_annotation.dart';

class SearchHistoryEntity extends Equatable {
  final int id;
  final int location;
  final int locationId;
  final String locationName;
  final String vendorName;
  final String address;

  const SearchHistoryEntity({
    this.id = -1,
    this.location = -1,
    this.locationId = -1,
    this.locationName = '',
    this.vendorName = '',
    this.address = '',
  });

  @override
  List<Object?> get props => [id, location, locationId, locationName, vendorName, address];
}

class SearchHistoryConverter<S> implements JsonConverter<SearchHistoryEntity, Map<String, dynamic>?> {
  const SearchHistoryConverter();

  @override
  SearchHistoryModel fromJson(Map<String, dynamic>? json) => SearchHistoryModel.fromJson(json ?? {});

  @override
  Map<String, dynamic> toJson(SearchHistoryEntity object) => SearchHistoryModel(
        id: object.id,
        location: object.location,
        locationId: object.locationId,
      ).toJson();
}
