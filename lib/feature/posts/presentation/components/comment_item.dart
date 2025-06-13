import 'package:flutter/material.dart';

import '../models/comment_ui.dart';

class CommentItem extends StatelessWidget {
  const CommentItem({super.key, required this.comment});

  final CommentUi comment;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text(
                      comment.user.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Text(comment.text, style: const TextStyle(fontSize: 14.0)),
                  const SizedBox(height: 4.0),
                  Text(
                    comment.timeSinceCommented,
                    style: const TextStyle(fontSize: 12.0),
                  ),
                  const SizedBox(height: 4.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
