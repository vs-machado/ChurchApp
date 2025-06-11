import 'package:flutter/material.dart';

import '../models/comment_ui.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment});

  final CommentUi comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage:
                comment.user.avatarUrl != null
                    ? NetworkImage(comment.user.avatarUrl!)
                    : const AssetImage(
                          'lib/core/assets/images/profile_image.png',
                        )
                        as ImageProvider,
            radius: 20.0,
          ),
          const SizedBox(width: 10.0),
          Padding(
            padding: const EdgeInsets.only(top: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 16.0,
                    ),
                    comment.user.name,
                  ),
                ),
                Text(style: const TextStyle(fontSize: 14.0), comment.text),
                Text(
                  style: const TextStyle(fontSize: 12.0),
                  comment.timeSinceCommented,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
