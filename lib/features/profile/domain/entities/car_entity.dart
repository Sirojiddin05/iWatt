import 'package:equatable/equatable.dart';
import 'package:i_watt_app/features/profile/data/models/car_model.dart';
import 'package:json_annotation/json_annotation.dart';

class CarEntity extends Equatable {
  final int id;
  final int manufacturer;
  final int model;
  final int typeStateNumber;
  final List<int> chargingType;
  final int vehicleType;
  final String name;
  final String vin;
  final String icon;
  final String stateNumber;
  final List<String> chargingTypeName;
  final String vehicleTypeName;
  final double usableBatterySize;
  final String brand;
  final String releaseYear;
  final String variant;
  final String modelName;
  final String manufacturerName;
  final String customModel;
  final String customManufacturer;
  final String version;

  const CarEntity({
    this.id = -1,
    this.name = '',
    this.model = -1,
    this.typeStateNumber = -1,
    this.chargingType = const [],
    this.manufacturer = -1,
    this.vehicleType = -1,
    this.vin = '',
    this.stateNumber = '',
    this.chargingTypeName = const [],
    this.vehicleTypeName = '',
    this.customManufacturer = '',
    this.usableBatterySize = -1,
    this.brand = '',
    this.releaseYear = '',
    this.variant = '',
    this.modelName = '',
    this.version = '',
    this.icon = '',
    this.customModel = '',
    this.manufacturerName = '',
  });

  CarEntity copyWith({
    int? id,
    String? name,
    int? model,
    int? manufacturer,
    int? typeStateNumber,
    List<int>? chargingType,
    int? vehicleType,
    String? vin,
    String? stateNumber,
    List<String>? chargingTypeName,
    String? vehicleTypeName,
    double? usableBatterySize,
    String? brand,
    String? releaseYear,
    String? variant,
    String? customManufacturer,
    String? modelName,
    String? manufacturerName,
    String? version,
    String? icon,
    String? customModel,
  }) =>
      CarEntity(
        id: id ?? this.id,
        name: name ?? this.name,
        customManufacturer: customManufacturer ?? this.customManufacturer,
        model: model ?? this.model,
        typeStateNumber: typeStateNumber ?? this.typeStateNumber,
        chargingType: chargingType ?? this.chargingType,
        vehicleType: vehicleType ?? this.vehicleType,
        vin: vin ?? this.vin,
        stateNumber: stateNumber ?? this.stateNumber,
        chargingTypeName: chargingTypeName ?? this.chargingTypeName,
        vehicleTypeName: vehicleTypeName ?? this.vehicleTypeName,
        usableBatterySize: usableBatterySize ?? this.usableBatterySize,
        brand: brand ?? this.brand,
        releaseYear: releaseYear ?? this.releaseYear,
        variant: variant ?? this.variant,
        modelName: modelName ?? this.modelName,
        version: version ?? this.version,
        manufacturer: manufacturer ?? this.manufacturer,
        manufacturerName: manufacturerName ?? this.manufacturerName,
        icon: icon ?? this.icon,
        customModel: customModel ?? this.customModel,
      );

  Map<String, dynamic> toApi() => {
        'name': name,
        'model': model,
        'manufacturer': manufacturer,
        'type_state_number': typeStateNumber > 0 ? typeStateNumber : null,
        'charging_type': chargingType,
        'vehicle_type': vehicleType > 0 ? vehicleType : null,
        'vin': vin,
        'state_number': stateNumber,
        'charging_type_name': chargingTypeName,
        'vehicle_type_name': vehicleTypeName,
        'usable_battery_size': usableBatterySize,
        'brand': brand,
        'release_year': releaseYear,
        'variant': variant,
        'model_name': modelName,
        'version': version.isNotEmpty ? version : null,
        'icon': icon,
        'manufacturer_name': manufacturerName,
        'custom_model': customModel
      };

  @override
  List<Object?> get props => [
        id,
        name,
        model,
        typeStateNumber,
        stateNumber,
        chargingType,
        customManufacturer,
        manufacturer,
        vehicleType,
        chargingTypeName,
        vehicleTypeName,
        version,
        vin,
        modelName,
        variant,
        releaseYear,
        usableBatterySize,
        brand,
        icon,
        customModel,
        manufacturerName
      ];
}

class CarEntityConverter<S> implements JsonConverter<CarEntity, Map<String, dynamic>?> {
  const CarEntityConverter();

  @override
  CarModel fromJson(Map<String, dynamic>? json) => CarModel.fromJson(json ?? {});

  @override
  Map<String, dynamic> toJson(CarEntity object) => CarModel(
        vehicleTypeName: object.vehicleTypeName,
        vehicleType: object.vehicleType,
        model: object.model,
        chargingType: object.chargingType,
        id: object.id,
        name: object.name,
        vin: object.vin,
        manufacturer: object.manufacturer,
        customManufacturer: object.customManufacturer,
        typeStateNumber: object.typeStateNumber,
        stateNumber: object.stateNumber,
        chargingTypeName: object.chargingTypeName,
        usableBatterySize: object.usableBatterySize,
        brand: object.brand,
        releaseYear: object.releaseYear,
        variant: object.variant,
        modelName: object.modelName,
        version: object.version,
        icon: object.icon,
        customModel: object.customModel,
      ).toJson();
}
