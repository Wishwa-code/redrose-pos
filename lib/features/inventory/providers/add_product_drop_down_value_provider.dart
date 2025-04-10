import 'package:flutter_riverpod/flutter_riverpod.dart';

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

final departmentProvider = Provider.autoDispose<List<Department>>((_) {
  return _departments;
});

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
