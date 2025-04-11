//!beter refactor this code might be actually unnessary because fetching these values from db is just enough

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import './enums_provider.dart';

part 'add_product_drop_down_value_provider.g.dart';

class Department {
  Department(this.name);
  final String name;
}

class Categories {
  Categories(this.name);
  String name;
}

final List<Department> _departments = [
  Department('mainBuilding'),
  Department('mainBuilding'),
  Department('mainBuilding'),
  Department('mainBuilding'),
  Department('mainBuilding'),
  Department('mainBuilding'),
];

final List<Categories> _categories = [
  Categories('cement'),
];

// final departmentProvider = Provider.autoDispose<List<Department>>((_) {
//   return _departments;
// });

@riverpod
Future<List<Department>> department(Ref ref) async {
  final groupedEnums = await ref.watch(enumsProvider.future);

  // Filter and map the department values
  final departments =
      groupedEnums['department']?.map((e) => Department(e.enumValue)).toList() ?? [];

  return departments;
}

// const int currentUserId = 1;

// final facilityProvider = Provider.autoDispose.family<List<String>, bool>((_, showAllPatients) {
//   return _patients
//       .where((patient) => showAllPatients || patient.clinicianId == currentUserId)
//       .map((patient) => patient.facility)
//       .toSet()
//       .toList();
// });

// final patientProvider = Provider.autoDispose.family<List<Patient>, (bool, String?)>((_, data) {
//   final (showAllPatients, facility) = data;

//   if (facility == null) {
//     return [];
//   }

//   return _patients
//       .where((patient) => showAllPatients || patient.clinicianId == currentUserId)
//       .where((patient) => patient.facility == facility)
//       .toList();
// });
