import 'package:i_watt_app/features/list/data/models/price_model.dart';
import 'package:json_annotation/json_annotation.dart';

class PriceEntity {
  final int id;
  final String priceConnector;
  final String priceType;
  final String priceParking;
  final String priceParkingType;
  final String priceWaiting;
  final String priceWaitingType;

  const PriceEntity({
    this.id = 0,
    this.priceConnector = '',
    this.priceType = '',
    this.priceParking = '',
    this.priceParkingType = '',
    this.priceWaiting = '',
    this.priceWaitingType = '',
  });
}

class PriceConverter implements JsonConverter<PriceEntity, Map<String, dynamic>> {
  const PriceConverter();

  @override
  PriceEntity fromJson(Map<String, dynamic> json) => PriceModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(PriceEntity object) => {};
}
