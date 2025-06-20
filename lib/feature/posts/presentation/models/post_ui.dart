import 'dart:io';

import 'package:church_app/feature/posts/domain/post.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../../core/domain/value_objects/user.dart';

/// Representa uma postagem na camada de interface do usuário.
class PostUi {
  /// Identificador único da postagem.
  final int id;

  /// Usuário que criou a postagem.
  final User user;

  /// Tempo decorrido desde a postagem.
  final String timeSincePosted;

  /// Horário da postagem a ser exibido ao usuário.
  final String formattedPostedTime;

  /// Tempo decorrido desde a edição do post.
  final String? timeSinceEdited;

  /// Conteúdo da postagem.
  final String text;

  /// URL da foto da postagem.
  final String? photoUrl;

  /// URL do vídeo da postagem.
  final String? videoUrl;

  /// Quantidade de likes da postagem.
  final int likesCount;

  PostUi({
    required this.id,
    required this.user,
    required this.timeSincePosted,
    required this.formattedPostedTime,
    this.timeSinceEdited,
    required this.text,
    this.photoUrl,
    this.videoUrl,
    required this.likesCount,
  });
}

// TODO: obter currentTime utilizando NTP quando o dispositivo tiver internet. Caso não
// tenha, utilizar o DateTime local.
