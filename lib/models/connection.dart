import 'dart:convert';

import 'package:checkup/models/connection_key.dart';
import 'package:collection/collection.dart';

class Connection {
  const Connection({this.connectionKey});

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Connection].
  factory Connection.fromJson(String data) {
    return Connection.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  factory Connection.fromMap(Map<String, dynamic> data) => Connection(
        connectionKey: data['connectionKey'] == null
            ? null
            : ConnectionKey.fromMap(
                data['connectionKey'] as Map<String, dynamic>,
              ),
      );

  final ConnectionKey? connectionKey;

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    if (other is! Connection) return false;
    final mapEquals = const DeepCollectionEquality().equals;
    return mapEquals(other.toMap(), toMap());
  }

  @override
  int get hashCode => connectionKey.hashCode;

  @override
  String toString() => 'Connection(connectionKey: $connectionKey)';

  /// `dart:convert`
  ///
  /// Converts [Connection] to a JSON string.
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'connectionKey': connectionKey?.toMap(),
      };
}
