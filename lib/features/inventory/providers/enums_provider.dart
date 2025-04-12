import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/api/api_client_service.dart';
import '/api/product_tree.dart';

part 'enums_provider.g.dart';

@riverpod
class Rrenums extends _$Rrenums {
  @override
  Future<Map<String, TreeNode>> build() async {
    final apiService = await ref.watch(apiServiceProvider.future);

    final groupedEnums = await apiService.fetchEnumsAndBuildTree();

    print('grouped ennums $groupedEnums');

    return groupedEnums;
  }
}
