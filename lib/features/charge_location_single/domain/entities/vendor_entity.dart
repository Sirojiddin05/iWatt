import 'package:i_watt_app/features/charge_location_single/data/models/vendor_model.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:json_annotation/json_annotation.dart';

class VendorEntity {
  final String name;
  final String minimumBalance;
  final String email;
  final String website;
  final String logo;
  final String phone;
  @IdNameConverter()
  final List<IdNameEntity> socialMedia;
  final bool integrated;
  final String appStoreUrl;
  final String playMarketUrl;
  final String organizationName;
  final String appName;

  const VendorEntity({
    this.name = '',
    this.minimumBalance = '',
    this.email = '',
    this.website = '',
    this.logo = '',
    this.phone = '',
    this.socialMedia = const [],
    this.integrated = false,
    this.appStoreUrl = '',
    this.playMarketUrl = '',
    this.organizationName = '',
    this.appName = '',
  });
}

class VendorConverter implements JsonConverter<VendorEntity, Map<String, dynamic>> {
  const VendorConverter();

  @override
  VendorEntity fromJson(Map<String, dynamic> json) => VendorModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(VendorEntity object) => {};
}
