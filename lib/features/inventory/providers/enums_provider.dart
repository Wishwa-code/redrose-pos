import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/api/api_client_service.dart';
import '../models/enum_item.dart';

part 'enums_provider.g.dart';

@riverpod
class Enums extends _$Enums {
  @override
  Future<Map<String, List<EnumItem>>> build() async {
    final apiService = await ref.watch(apiServiceProvider.future);

    final groupedEnums = await apiService.getEnums();

    print('grouped ennums $groupedEnums');

    return groupedEnums;
  }
}
