import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:i_watt_app/features/profile/data/models/car_model.dart';
import 'package:json_annotation/json_annotation.dart';

class CarEntity extends Equatable {
  final int id;
  final String manufacturer;
  final String model;
  final int stateNumberType;
  final String stateNumber;
  @IdNameConverter()
  final List<IdNameEntity> connectorType;
  final String vin;

  const CarEntity({
    this.id = -1,
    this.model = '',
    this.stateNumberType = -1,
    this.connectorType = const [],
    this.manufacturer = '',
    this.vin = '',
    this.stateNumber = '',
  });

  CarEntity copyWith({
    int? id,
    String? model,
    String? manufacturer,
    int? stateNumberType,
    List<IdNameEntity>? connectorType,
    String? vin,
    String? stateNumber,
  }) =>
      CarEntity(
        id: id ?? this.id,
        model: model ?? this.model,
        stateNumberType: stateNumberType ?? this.stateNumberType,
        connectorType: connectorType ?? this.connectorType,
        vin: vin ?? this.vin,
        stateNumber: stateNumber ?? this.stateNumber,
        manufacturer: manufacturer ?? this.manufacturer,
      );

  Map<String, dynamic> toApi() => {
        'id': id,
        'model': model,
        'manufacturer': manufacturer,
        'state_number': stateNumber,
        'state_number_type': stateNumberType > 0 ? stateNumberType : null,
        'vin': vin.isNotEmpty ? vin : null,
        for (int i = 0; i < connectorType.length; i++) 'connector_type[$i]': connectorType[i].id,
      };

  @override
  List<Object> get props => [
        id,
        manufacturer,
        model,
        stateNumberType,
        stateNumber,
        connectorType,
        vin,
      ];
}

class CarEntityConverter<S> implements JsonConverter<CarEntity, Map<String, dynamic>?> {
  const CarEntityConverter();

  @override
  CarModel fromJson(Map<String, dynamic>? json) => CarModel.fromJson(json ?? {});

  @override
  Map<String, dynamic> toJson(CarEntity object) => CarModel(
        model: object.model,
        connectorType: object.connectorType,
        id: object.id,
        vin: object.vin,
        manufacturer: object.manufacturer,
        stateNumber: object.stateNumber,
        stateNumberType: object.stateNumberType,
      ).toJson();
}
