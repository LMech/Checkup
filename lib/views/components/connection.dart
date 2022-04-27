import 'package:flutter/material.dart';
import 'avatar.dart';

class Connection extends StatelessWidget {
  final Map<String, dynamic>? connectionData;
  final bool isFriend;

  const Connection({
    Key? key,
    required this.connectionData,
    required this.isFriend,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5.0,
      ),
      child: ClipRRect(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {},
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Avatar(
                        connectionData!['photourl'] ?? '',
                        width: 75,
                        radius: 30,
                        height: 75,
                      )),
                  title: Text(
                    connectionData!['name'],
                  ),
                  subtitle: Text(
                    connectionData!['email'],
                  ),
                ),
                const SingleChildScrollView()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
