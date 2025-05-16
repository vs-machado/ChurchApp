import 'package:flutter/material.dart';
import 'package:church_app/feature/posts/presentation/models/post_ui.dart';

class PostItem extends StatelessWidget {
  const PostItem({super.key, required this.post});

  final PostUi post;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Row(
            children: [
              // Foto de perfil do usuário
              CircleAvatar(
                backgroundImage:
                    post.userAvatarUrl != null
                        ? NetworkImage(post.userAvatarUrl!)
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
                        post.userName,
                      ),
                    ),
                    Text(
                      style: const TextStyle(fontSize: 12.0),
                      post.timeSincePosted,
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
          padding: const EdgeInsets.only(left: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => Scaffold(
                        appBar: AppBar(title: const Text('Post completo')),
                        body: SingleChildScrollView(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            post.text,
                            style: const TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                ),
              );
            },
            child: LayoutBuilder(
              builder: (context, constraints) {
                final text = post.text;
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
        if (post.videoUrl != null) ...[
          const Text('Video Player Placeholder'),
          const SizedBox(height: 10.0),
        ] else if (post.photoUrl != null) ...[
          Image.network(
            post.photoUrl!,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 10.0),
        ],

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.thumb_up_outlined),
              label: const Text('Curtir'),
            ),
            TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.comment_outlined),
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
}
