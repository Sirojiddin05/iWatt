import 'package:i_watt_app/features/list/domain/entities/price_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'price_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class PriceModel extends PriceEntity {
  const PriceModel({
    super.id,
    super.priceConnector,
    super.priceParking,
    super.priceParkingType,
    super.priceType,
    super.priceWaiting,
    super.priceWaitingType,
  });

  factory PriceModel.fromJson(Map<String, Object?> json) => _$PriceModelFromJson(json);
}
