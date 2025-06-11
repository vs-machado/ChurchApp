import 'dart:io';

import 'package:church_app/feature/posts/domain/post.dart';
import 'package:intl/intl.dart';
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

extension PostToUi on Post {
  /// Instancia o objeto PostUi.
  ///
  /// Caso um horário do server NTP não seja providenciado utiliza o horário do dispositivo.
  ///
  /// [ntpTime] - Horário de servidor utilizado para calcular o tempo decorrido desde a postagem ou edição.
  PostUi toUi(DateTime? ntpTime) {
    String locale = Platform.localeName;

    final timeSincePosted =
        ntpTime != null
            ? timeago.format(createdAt, locale: locale, clock: ntpTime)
            : timeago.format(createdAt, locale: locale);
    final timeSinceEdited =
        editedAt != null
            ? (ntpTime != null
                ? timeago.format(editedAt!, locale: locale, clock: ntpTime)
                : timeago.format(editedAt!, locale: locale))
            : null;

    // Converte o horário de criação do post para o fuso horário do usuário
    final localCreatedAt = createdAt.toLocal();
    final dateFormatter = DateFormat.yMd(locale).add_Hm();
    final formattedPostedTime = dateFormatter.format(localCreatedAt);

    return PostUi(
      id: id,
      user: user,
      timeSincePosted: timeSincePosted,
      formattedPostedTime: formattedPostedTime,
      timeSinceEdited: timeSinceEdited,
      text: text,
      photoUrl: photoUrl,
      videoUrl: videoUrl,
      likesCount: likesCount,
    );
  }
}
