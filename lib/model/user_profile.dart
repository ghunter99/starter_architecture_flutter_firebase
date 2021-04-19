import 'dart:ui';

import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  const UserProfile({
    @required this.uid,
    @required this.firstName,
    @required this.lastName,
  })  : assert(uid != null),
        assert(firstName != null),
        assert(lastName != null);

  factory UserProfile.fromMap(Map<String, dynamic> data) {
    if (data == null) {
      return null;
    }
    final String uid = data['uid'] as String;
    if (uid == null) {
      return null;
    }
    final String firstName = data['firstName'] as String;
    if (firstName == null) {
      return null;
    }
    final String lastName = data['lastName'] as String;
    if (lastName == null) {
      return null;
    }
    return UserProfile(
      uid: uid,
      firstName: firstName,
      lastName: lastName,
    );
  }

  final String uid;
  final String firstName;
  final String lastName;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  UserProfile copyWith({
    String uid,
    String firstName,
    String lastName,
  }) {
    return UserProfile(
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
    );
  }

  bool get isComplete {
    if (firstName != null &&
        lastName != null &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  int get hashCode => hashValues(
        uid,
        firstName,
        lastName,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is UserProfile) {
      final otherUser = other;
      return uid == otherUser.uid &&
          firstName == otherUser.firstName &&
          lastName == otherUser.lastName;
    }
    return false;
  }
}
