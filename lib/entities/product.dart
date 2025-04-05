import 'package:freezed_annotation/freezed_annotation.dart';

part 'product.freezed.dart';

/// The response of the `GET /api/activity` endpoint.
///
/// It is defined using `freezed` and `json_serializable`.
@freezed
sealed class Product with _$Product {
  factory Product({
    required int id,
    required String title,
    required String description,
    required String tagOne,
    required String tagTwo,
    required String imageUrl,
    required String supplier,
    required String brand,
    required String department,
    required String mainCategory,
    required String subCategory,
  }) = _Product;

  /// Convert a JSON object into an [Activity] instance.
  /// This enables type-safe reading of the API response.
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: int.tryParse(json['id'] as String) ?? 0,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      tagOne: json['tag_one'] as String? ?? '',
      tagTwo: json['ta_two'] as String? ?? '',
      imageUrl: json['imageurl'] as String? ?? '',
      supplier: json['supplier_tb'] as String? ?? '',
      brand: json['brand'] as String? ?? '',
      department: json['department'] as String? ?? '',
      mainCategory: json['main_category'] as String? ?? '',
      subCategory: json['sub_category'] as String? ?? '',
    );
  }
}
