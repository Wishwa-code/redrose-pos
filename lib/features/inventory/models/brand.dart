import 'package:freezed_annotation/freezed_annotation.dart';

part 'brand.freezed.dart';
part 'brand.g.dart'; // <- needed for JSON (de)serialization

@freezed
class Brand with _$Brand {
  factory Brand({
    @JsonKey(fromJson: _idFromJson) int? id, // optional for inserts
    required String name,
    required String description,
    @JsonKey(name: 'logourl') required String logourl,
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'country_of_origin') required String countryOfOrigin,
    @JsonKey(name: 'social_media_links') required String socialMediaLinks,
    @JsonKey(name: 'contact_email') required String contactEmail,
    @JsonKey(name: 'phone_number') required String phoneNumber,
    @JsonKey(name: 'banner_url') required String bannerUrl,
    @JsonKey(name: 'website') required String website,
  }) = _Brand;

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);
}

int? _idFromJson(dynamic id) {
  if (id is int) return id;
  if (id is String) return int.tryParse(id);
  return null;
}
