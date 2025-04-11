import 'package:freezed_annotation/freezed_annotation.dart';

part 'enum_item.freezed.dart';
part 'enum_item.g.dart';

@freezed
class EnumItem with _$EnumItem {
  const factory EnumItem({
    @JsonKey(name: 'enum_schema') required String enumSchema,
    @JsonKey(name: 'enum_name') required String enumName,
    @JsonKey(name: 'enum_value') required String enumValue,
  }) = _EnumItem;

  factory EnumItem.fromJson(Map<String, dynamic> json) => _$EnumItemFromJson(json);
}
