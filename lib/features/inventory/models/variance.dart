import 'package:freezed_annotation/freezed_annotation.dart';

part 'variance.freezed.dart';
part 'variance.g.dart'; // <- needed for JSON (de)serialization

@freezed
class Variance with _$Variance {
  factory Variance({
    @JsonKey(fromJson: _idFromJson) int? id, // optional for inserts
    required String productName,
    @JsonKey(name: 'product_id') required String productId,
    required String displayTitle,
    @JsonKey(name: 'about_this_variance') required String varianceDescription,
    @JsonKey(name: 'imageurl') required String imageUrl,
    @JsonKey(name: 'variance') required String varianceTitle,
    @JsonKey(name: 'brand') required String brand,
    @JsonKey(name: 'supplier') required String supplier,
    @JsonKey(name: 'original_price') required int originalPrice,
    @JsonKey(name: 'retail_price') required int retailPrice,
    @JsonKey(name: 'wholesale_price') required String wholesalePrice,
  }) = _Variance;

  factory Variance.fromJson(Map<String, dynamic> json) => _$VarianceFromJson(json);
}

int? _idFromJson(dynamic id) {
  if (id is int) return id;
  if (id is String) return int.tryParse(id);
  return null;
}
