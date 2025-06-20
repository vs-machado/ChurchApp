// lib/feature/posts/presentation/components/create_post.dart
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Criar Postagem'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: TextButton(
              onPressed: () {
                // TODO: Implementar a lógica de criação do post
                Navigator.of(context).pop();
              },
              child: const Text('Publicar'),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _textController,
              autofocus: true,
              maxLines: 15,
              decoration: const InputDecoration(
                hintText: 'No que você está pensando?',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),
            ),
            const Spacer(),
            const Divider(),
            TextButton.icon(
              onPressed: () {
                // TODO: Implementar a lógica para anexar imagem
              },
              icon: const Icon(Icons.image_outlined),
              label: const Text('Anexar imagem'),
              style: TextButton.styleFrom(alignment: Alignment.centerLeft),
            ),
          ],
        ),
      ),
    );
  }
}
