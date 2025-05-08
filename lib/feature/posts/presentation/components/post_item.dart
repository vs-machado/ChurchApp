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
            Column(
              // TODO: adicionar um padding top?
              children: [
                // Nome do usuário
                InkWell(
                  onTap: () {},
                  child: const Text(
                    'Vinicius Santos', // TODO: passar o username
                  ),
                ),
                // Há quanto tempo foi postado
                const Text(
                  style: TextStyle(fontSize: 10.0),
                  'há 1h', // TODO: passar há quanto tempo foi postado
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 10.0),

        // Conteúdo do post em texto
        Text(lorem(paragraphs: 1, words: 60)),
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
