import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/api/api_client_service.dart';
import '../../../utils/print_logger.dart';
import '../models/supplier.dart';

part 'supplier_provider.g.dart';

@riverpod
class SupplierNotifier extends _$SupplierNotifier {
  @override
  Future<List<Supplier>> build() async {
    //fetch last product from the api
    final apiService = await ref.watch(apiServiceProvider.future);

    final response = await apiService.fetchSuppliers();
    // logger.d('✈️ Supplier API call response $response');

    // print(response);

    return response;
  }

  Future<Supplier> addSupplier(Supplier supplier) async {
    //fetch last product from the api
    final apiService = await ref.watch(apiServiceProvider.future);

    final response = await apiService.addSupplier(supplier);
    logger.e('🌿 Brand API call response $response');

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
