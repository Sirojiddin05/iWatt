import 'package:i_watt_app/features/charge_location_single/domain/entities/vendor_entity.dart';
import 'package:i_watt_app/features/common/domain/entities/id_name_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'vendor_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VendorModel extends VendorEntity {
  const VendorModel({
    super.name,
    super.minimumBalance,
    super.email,
    super.website,
    super.logo,
    super.phone,
    super.socialMedia,
  });

  factory VendorModel.fromJson(Map<String, dynamic> json) => _$VendorModelFromJson(json);

  Map<String, dynamic> toJson() => _$VendorModelToJson(this);
}
