import 'package:flutter/material.dart';
import 'package:church_app/feature/posts/presentation/models/post_ui.dart';

import '../../../../generated/l10n.dart';

class PostItem extends StatefulWidget {
  const PostItem({super.key, required this.post});

  final PostUi post;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Row(
            children: [
              CircleAvatar(
                backgroundImage:
                    widget.post.user.avatarUrl != null
                        ? NetworkImage(widget.post.user.avatarUrl!)
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
                        widget.post.user.name,
                      ),
                    ),
                    Text(
                      style: const TextStyle(fontSize: 12.0),
                      widget.post.timeSincePosted,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),

        // Conteúdo do post em texto
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
                  style: const TextStyle(fontSize: 14.0, color: Colors.black),
                );
                final TextPainter textPainter = TextPainter(
                  text: textSpan,
                  maxLines: 6,
                  textDirection: TextDirection.ltr,
                )..layout(maxWidth: constraints.maxWidth);

                final bool isTextOverflowing = textPainter.didExceedMaxLines;

                if (isTextOverflowing) {
                  final charactersPerLine =
                      text.length /
                      (textPainter.height / textPainter.preferredLineHeight);
                  final visibleTextLength = (charactersPerLine * 4.8).toInt();
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

        // Exibe um vídeo ou imagem caso o usuário faça upload.
        // A implementação atual será de apenas exibir uma imagem ou um vídeo.
        // Caso por alguma falha do código o usuário faça upload de uma foto e um vídeo
        // apenas o vídeo será exibido.
        if (widget.post.videoUrl != null) ...[
          const Text('Video Player Placeholder'),
          const SizedBox(height: 10.0),
        ] else if (widget.post.photoUrl != null) ...[
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                '/postDetails',
                arguments: widget.post,
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  widget.post.photoUrl!,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
        ],

        // Exibe a contagem de curtidas caso alguém curta a postagem
        if (widget.post.likesCount > 0) ...{
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Likes count
                Text(
                  S.of(context).likesCount(widget.post.likesCount),
                  style: TextStyle(fontSize: 14.0),
                ),
                const SizedBox(width: 5.0),
                const Icon(
                  Icons.thumb_up,
                  color: Colors.deepPurple,
                  size: 16.0,
                ),
                // TODO: implement a comments counter
              ],
            ),
          ),
        },

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Divider(height: 15.0),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildAnimatedButton(
              onPressed: () {
                setState(() {
                  isLiked = !isLiked;
                });
                // TODO: check if it's possible to update the like counter to increment the user like
                // TODO: needs to update both the string and the database
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
              label: isLiked ? 'Descurtir' : 'Curtir',
              isActive: isLiked,
            ),
            TextButton.icon(
              onPressed: () {},
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
      ],
    );
  }

  Widget _buildAnimatedButton({
    required VoidCallback onPressed,
    required Widget icon,
    required String label,
    required bool isActive,
  }) {
    return TextButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        label,
        style: TextStyle(color: isActive ? Colors.deepPurple : null),
      ),
    );
  }
}
