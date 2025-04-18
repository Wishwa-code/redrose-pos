import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/api/api_client_service.dart';
import '../../../utils/print_logger.dart';
import '../models/brand.dart';

part 'brand_provider.g.dart';

@riverpod
class BrandNotifier extends _$BrandNotifier {
  @override
  Future<List<Brand>> build() async {
    //fetch last product from the api
    final apiService = await ref.watch(apiServiceProvider.future);

    final response = await apiService.fetchBrands();
    logger.d('🌿 Brand API call response $response');

    // print(response);

    return response;
  }

  // Future<void> addSupplier(Product product, File imageFile) async {
  //   final apiService = await ref.watch(apiServiceProvider.future);

  //   final newSupplier = await apiService.addSupplier(product, imageFile);

  //   print(newSupplier);

  //   // Update the state
  //   state = AsyncData(newSupplier);
  // }

  // Future<void> updateSupplier(Product product, File imageFile) async {
  //   final apiService = await ref.watch(apiServiceProvider.future);

  //   final newSupplier = await apiService.updateSupplier(product, imageFile);

  //   print(newSupplier);

  //   // Update the state
  //   state = AsyncData(newSupplier);
  // }
}
