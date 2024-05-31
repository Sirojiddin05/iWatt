import 'package:i_watt_app/features/charge_location_single/data/models/vendor_model.dart';
import 'package:json_annotation/json_annotation.dart';

class VendorEntity {
  final String name;
  final String minimumBalance;
  final String email;
  final String website;
  final String logo;
  final String phone;

  const VendorEntity({
    this.name = '',
    this.minimumBalance = '',
    this.email = '',
    this.website = '',
    this.logo = '',
    this.phone = '',
  });
}

class VendorConverter implements JsonConverter<VendorEntity, Map<String, dynamic>> {
  const VendorConverter();

  @override
  VendorEntity fromJson(Map<String, dynamic> json) => VendorModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(VendorEntity object) => {};
}
