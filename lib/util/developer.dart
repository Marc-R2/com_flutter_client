part of '../com_flutter_client.dart';

class Developer {
  const Developer({
    required this.firstName,
    required this.lastName,
    this.email,
    this.company = 'BitBot UG',
    this.role = 'Developer',
  });

  const Developer.MarcRenken({
    this.firstName = 'Marc',
    this.lastName = 'Renken',
    this.email = 'marc.renken@bitbot.eu',
    this.role = 'Developer',
    this.company = 'BitBot UG',
  });

  const Developer.JonasWinzer({
    this.firstName = 'Jonas',
    this.lastName = 'Winzer',
    this.email = 'jonas.winzer@bitbot.eu',
    this.role = 'Developer',
    this.company = 'BitBot UG',
  });

  final String firstName;

  final String lastName;

  final String? email;

  final String company;

  final String role;

  String get fullName => '$firstName $lastName';

  String get initials => '${firstName[0]}${lastName[0]}';
}
