import 'package:cached_network_image/cached_network_image.dart';
import 'package:church_app/core/data/cache_manager/custom_cache_manager.dart';
import 'package:flutter/material.dart';
import 'package:church_app/feature/posts/presentation/models/post_ui.dart';

import '../../../../generated/l10n.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key, required this.post, this.onCommentPressed});

  final PostUi post;
  final VoidCallback? onCommentPressed;

  @override
  State<PostItem> createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> with TickerProviderStateMixin {
  bool isLiked = false;

  late AnimationController _likeController;

  @override
  void initState() {
    super.initState();
    _likeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 0),
      child: Padding(
        padding: const EdgeInsets.only(top: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage:
                        widget.post.user.avatarUrl != null
                            ? CachedNetworkImageProvider(
                              widget.post.user.avatarUrl!,
                            )
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
                            widget.post.user.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 16.0,
                            ),
                          ),
                        ),
                        Text(
                          widget.post.timeSincePosted,
                          style: const TextStyle(fontSize: 12.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10.0),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    '/postDetails',
                    arguments: widget.post,
                  );
                },
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final text = widget.post.text;
                    final TextSpan textSpan = TextSpan(
                      text: text,
                      style: const TextStyle(
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    );
                    final TextPainter textPainter = TextPainter(
                      text: textSpan,
                      maxLines: 6,
                      textDirection: TextDirection.ltr,
                    )..layout(maxWidth: constraints.maxWidth);

                    final bool isTextOverflowing =
                        textPainter.didExceedMaxLines;

                    if (isTextOverflowing) {
                      final charactersPerLine =
                          text.length /
                          (textPainter.height /
                              textPainter.preferredLineHeight);
                      final visibleTextLength =
                          (charactersPerLine * 4.8).toInt();
                      final visibleText = text.substring(
                        0,
                        visibleTextLength > text.length
                            ? text.length
                            : visibleTextLength,
                      );

                      return RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '$visibleText... ',
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.black,
                              ),
                            ),
                            const TextSpan(
                              text: 'Ver mais',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.purple,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.start,
                      );
                    } else {
                      return Text(
                        text,
                        style: const TextStyle(color: Colors.black),
                        textAlign: TextAlign.start,
                      );
                    }
                  },
                ),
              ),
            ),

            const SizedBox(height: 10.0),

            if (widget.post.videoUrl != null) ...[
              const Text('Video Player Placeholder'),
              const SizedBox(height: 10.0),
            ] else if (widget.post.photoUrl != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: CachedNetworkImage(
                    cacheManager: CustomCacheManager.instance,
                    imageUrl: widget.post.photoUrl!,
                    placeholder:
                        (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                    errorWidget:
                        (context, url, error) => const Icon(Icons.error),
                    width: double.infinity,
                    height: 250,
                    // ✅ Fixed height to remove blank space issues
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
            ],

            if (widget.post.likesCount > 0) ...{
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      S.of(context).likesCount(widget.post.likesCount),
                      style: const TextStyle(fontSize: 14.0),
                    ),
                    const SizedBox(width: 5.0),
                    const Icon(
                      Icons.thumb_up,
                      color: Colors.deepPurple,
                      size: 16.0,
                    ),
                  ],
                ),
              ),
            },

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        isLiked = !isLiked;
                      });

                      if (isLiked) {
                        _likeController.forward();
                      } else {
                        _likeController.reverse();
                      }
                    },
                    icon: AnimatedBuilder(
                      animation: _likeController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 1.0 + (_likeController.value * 0.4),
                          child: Icon(
                            isLiked ? Icons.thumb_up : Icons.thumb_up_outlined,
                            color: isLiked ? Colors.deepPurple : null,
                          ),
                        );
                      },
                    ),
                    label: Text(
                      isLiked ? 'Descurtir' : 'Curtir',
                      style: TextStyle(
                        color: isLiked ? Colors.deepPurple : null,
                      ),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () => widget.onCommentPressed?.call(),
                    icon: const Icon(Icons.chat_bubble_outline),
                    label: const Text('Comentar'),
                  ),
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.share_outlined),
                    label: const Text('Compartilhar'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
