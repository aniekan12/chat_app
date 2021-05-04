import 'package:flutter/material.dart';

class OtherChats extends StatelessWidget {
  final int index;
  final Map<String, dynamic> data;
  final bool showAvatar;

  const OtherChats({
    Key key,
    this.index,
    this.data,
    this.showAvatar = true,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 6,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showAvatar)
            CircleAvatar(
              backgroundImage: NetworkImage(data['photo_url']),
            )
          else
            SizedBox(
              width: 40,
            ),
          SizedBox(
            width: 10,
          ),
          Container(
            constraints: BoxConstraints(
              maxWidth: 300,
            ),
            padding: EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data['author']} said: ',
                  style: TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(data['value']),
                // Text(data['timestamp'].toString()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
