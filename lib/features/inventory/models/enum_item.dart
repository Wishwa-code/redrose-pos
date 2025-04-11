import 'package:freezed_annotation/freezed_annotation.dart';

part 'enum_item.freezed.dart';
part 'enum_item.g.dart';

@freezed
class EnumItem with _$EnumItem {
  const factory EnumItem({
    @JsonKey(name: 'enum_schema') required String enumSchema,
    @JsonKey(name: 'enum_name') required String enumName,
    @JsonKey(name: 'enum_value') required String enumValue,
    // Store the index (key) of the parent node from the tree.
    // It's nullable because the root won't have a parent.
    // Use @JsonKey(ignore: true) if you don't want this serialized/deserialized
    // if it's only calculated locally and not coming from the API.
    // If it *could* come from the API, give it a proper @JsonKey name.
    @JsonKey(includeFromJson: false, includeToJson: false) // Or use ignore: true
    String? parentIndex,
  }) = _EnumItem;

  factory EnumItem.fromJson(Map<String, dynamic> json) => _$EnumItemFromJson(json);
}
