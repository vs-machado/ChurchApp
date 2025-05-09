import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

class PostItem extends StatelessWidget {
  const PostItem({
    super.key,
    required this.avatarUrl,
    this.imageUrl,
    this.videoUrl,
  });

  final String? avatarUrl;
  final String? imageUrl;
  final String? videoUrl;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            // Foto de perfil do usuário
            CircleAvatar(
              backgroundImage:
                  avatarUrl != null
                      ? NetworkImage(avatarUrl!)
                      : AssetImage('lib/core/assets/images/profile_image.png'),
              radius: 20.0,
            ),
            const SizedBox(width: 10.0),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome do usuário
                  InkWell(
                    onTap: () {},
                    child: const Text(
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 16.0,
                      ),
                      'Vinicius Santos', // TODO: passar o username
                    ),
                  ),
                  // Há quanto tempo foi postado
                  const Text(
                    style: TextStyle(fontSize: 12.0),
                    'há 1h', // TODO: passar há quanto tempo foi postado
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10.0),

        // Conteúdo do post em texto
        LayoutBuilder(
          builder: (context, constraints) {
            final text = lorem(paragraphs: 1, words: 60);
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

              return GestureDetector(
                onTap: () {
                  // Navega para a PostPage
                  Navigator.push(
                    context,
                    // TODO: Implementar uma página própria para a postagem
                    MaterialPageRoute(
                      builder:
                          (context) => Scaffold(
                            appBar: AppBar(title: const Text('Post completo')),
                            body: SingleChildScrollView(
                              padding: const EdgeInsets.all(16.0),
                              child: Text(
                                text,
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                    ),
                  );
                },
                child: RichText(
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
                ),
              );
            } else {
              return Text(text, style: const TextStyle(color: Colors.black));
            }
          },
        ),
        const SizedBox(height: 10.0),

        // Exibe um vídeo ou imagem caso o usuário faça upload.
        // A implementação atual será de apenas exibir uma imagem ou um vídeo.
        // Caso por alguma falha do código o usuário faça upload de uma foto e um vídeo
        // apenas o vídeo será exibido.
        if (videoUrl != null) ...[
          const Text('Video Player Placeholder'),
          const SizedBox(height: 10.0),
        ] else if (imageUrl != null) ...[
          Image.network(imageUrl!),
          const SizedBox(height: 10.0),
        ],

        // TODO: setar uma altura máxima para a imagem
        const Divider(),
        const SizedBox(height: 4.0),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton.icon(
              onPressed: () {
                // TODO: Implementar opção de like
              },
              icon: const Icon(Icons.thumb_up_outlined),
              label: const Text('Curtir'),
            ),
            TextButton.icon(
              onPressed: () {
                // TODO: Implementar opção de comentar
              },
              icon: const Icon(Icons.comment_outlined),
              label: const Text('Comentar'),
            ),
          ],
        ),
      ],
    );
  }
}
