import 'dart:io';

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../domain/post.dart';
import '../models/post_ui.dart';

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
