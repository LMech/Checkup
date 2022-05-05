import 'dart:convert';

import 'package:collection/collection.dart';

class ConnectionKey {
  const ConnectionKey({this.booleanValue});

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [ConnectionKey].
  factory ConnectionKey.fromJson(String data) {
    return ConnectionKey.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory ConnectionKey.fromMap(Map<String, dynamic> data) => ConnectionKey(
        booleanValue: data['booleanValue'] as bool?,
      );

  final bool? booleanValue;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! ConnectionKey) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => booleanValue.hashCode;

  @override
  String toString() => 'ConnectionKey(booleanValue: $booleanValue)';

  Map<String, dynamic> toMap() => {
        'booleanValue': booleanValue,
      };

  /// `dart:convert`
  ///
  /// Converts [ConnectionKey] to a JSON string.
  String toJson() => json.encode(toMap());
}
