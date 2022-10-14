import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'session.dart';

@immutable
class User extends Equatable {
  const User({
    required this.name,
    required this.lastName,
    required this.email,
    this.session = const Session(),
    this.id,
  });

  final String name;
  final String lastName;
  final String email;
  final Session session;
  final int? id;

  @override
  List<Object?> get props => [id, name, lastName];

  User copyWith({
    required String name,
    required String lastName,
    required String email,
    required Session session,
    int? id,
  }) =>
      User(
        name: name,
        lastName: lastName,
        email: email,
        session: session,
        id: id,
      );
}
