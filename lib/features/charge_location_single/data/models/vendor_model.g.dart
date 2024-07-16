// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vendor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VendorModel _$VendorModelFromJson(Map<String, dynamic> json) => VendorModel(
      name: json['name'] as String? ?? '',
      minimumBalance: json['minimum_balance'] as String? ?? '',
      email: json['email'] as String? ?? '',
      website: json['website'] as String? ?? '',
      logo: json['logo'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      socialMedia: (json['social_media'] as List<dynamic>?)
              ?.map((e) =>
                  const IdNameConverter().fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      integrated: json['integrated'] as bool? ?? false,
      appStoreUrl: json['app_store_url'] as String? ?? '',
      playMarketUrl: json['play_market_url'] as String? ?? '',
      organizationName: json['organization_name'] as String? ?? '',
    );

Map<String, dynamic> _$VendorModelToJson(VendorModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'minimum_balance': instance.minimumBalance,
      'email': instance.email,
      'website': instance.website,
      'logo': instance.logo,
      'phone': instance.phone,
      'social_media':
          instance.socialMedia.map(const IdNameConverter().toJson).toList(),
      'integrated': instance.integrated,
      'app_store_url': instance.appStoreUrl,
      'play_market_url': instance.playMarketUrl,
      'organization_name': instance.organizationName,
    };
