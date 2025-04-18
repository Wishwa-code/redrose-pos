import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier.freezed.dart';
part 'supplier.g.dart'; // <- needed for JSON (de)serialization

@freezed
class Supplier with _$Supplier {
  factory Supplier({
    @JsonKey(fromJson: _idFromJson) int? id, // optional for inserts
    required String name,
    required String description,
    @JsonKey(name: 'logourl') required String logourl,
    @JsonKey(name: 'website') required String website,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'country_of_origin') required String countryOfOrigin,
    @JsonKey(name: 'social_media_links') required String socialMediaLinks,
    @JsonKey(name: 'contact_email') required String contactEmail,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    @JsonKey(name: 'banner_url') required String bannerUrl,
    @JsonKey(name: 'city') required String locatedCity,
    @JsonKey(name: 'country') required String locatedCountry,
    @JsonKey(name: 'bank_details') required String bankDetails,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'extra_data') required String extraData,
  }) = _Supplier;

  factory Supplier.fromJson(Map<String, dynamic> json) => _$SupplierFromJson(json);
}

int? _idFromJson(dynamic id) {
  if (id is int) return id;
  if (id is String) return int.tryParse(id);
  return null;
}

