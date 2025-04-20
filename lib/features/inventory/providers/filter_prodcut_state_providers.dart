import 'package:flutter_riverpod/flutter_riverpod.dart';

final rootProvider = StateProvider<List<String>>((ref) => ['root', 'root']);
final searchFieldProvider = StateProvider<String>((ref) => '');
final departmentFilterProvider = StateProvider<List<String>>((ref) => []);
final categoryFilterProvider = StateProvider<List<String>>((ref) => []);
final currentPageProvider = StateProvider<int>((ref) => 1);
final lookinDescriptionProvider = StateProvider<bool>((ref) => false);
