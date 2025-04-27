import 'dart:io';

import 'package:logger/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '/api/api_client_service.dart';
import '../models/variance.dart';

part 'last_entered_variance_notifier.g.dart';

Logger logger = Logger(
  printer: PrettyPrinter(),
);

@riverpod
class LastVariance extends _$LastVariance {
  @override
  Future<Variance> build() async {
    //fetch last product from the api
    final apiService = await ref.watch(apiServiceProvider.future);

    final response = await apiService.fetchLastVariance();
    // print(response);

    return response;
  }

  Future<void> addVariance(Variance product, File imageFile) async {
    final apiService = await ref.watch(apiServiceProvider.future);

    final newProduct = await apiService.addVariance(product, imageFile);

    logger.d('add variance response: [pipe level:provider]$newProduct');

    // Update the state
    state = AsyncData(newProduct);
  }

  Future<void> fetchVarianceById(String id) async {
    state = const AsyncLoading(); // optional
    try {
      final apiService = await ref.watch(apiServiceProvider.future);
      final variance = await apiService.fetchVarianceById(id);
      state = AsyncData(variance);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> selectVariance(Variance product) async {
    state = const AsyncLoading(); // optional
    try {
      state = AsyncData(product);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
