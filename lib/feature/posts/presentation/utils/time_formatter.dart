import 'dart:io';

import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

/// Utilitário para formatação de datas e horários em formatos legíveis
class TimeFormatter {
  /// Formata um DateTime para exibir "há X tempo" (ex: "há 5 minutos")
  ///
  /// [dateTime] A data a ser formatada
  /// [referenceTime] Data de referência opcional (normalmente hora atual ou NTP)
  /// [locale] Configuração regional para formatação (ex: "pt_BR")
  static String formatTimeAgo(
    DateTime dateTime, {
    DateTime? referenceTime,
    String? locale,
  }) {
    final effectiveLocale = locale ?? Platform.localeName;

    if (referenceTime != null) {
      return timeago.format(
        dateTime,
        locale: effectiveLocale,
        clock: referenceTime,
      );
    }
    return timeago.format(dateTime, locale: effectiveLocale);
  }

  /// Formata um DateTime para uma string com data e hora local
  ///
  /// [dateTime] A data a ser formatada
  /// [locale] Configuração regional para formatação (ex: "pt_BR")
  /// [pattern] Padrão personalizado de formatação (opcional)
  static String formatDateTime(
    DateTime dateTime, {
    String? locale,
    String? pattern,
  }) {
    final effectiveLocale = locale ?? Platform.localeName;
    final localDateTime = dateTime.toLocal();

    final formatter =
        pattern != null
            ? DateFormat(pattern, effectiveLocale)
            : DateFormat.yMd(effectiveLocale).add_Hm();

    return formatter.format(localDateTime);
  }

  /// Retorna informações completas de tempo para um conteúdo (post ou comentário)
  ///
  /// [createdAt] Data de criação do conteúdo
  /// [editedAt] Data da última edição (opcional)
  /// [ntpTime] Tempo de referência NTP (opcional, para sincronização)
  /// [locale] Configuração regional para formatação (ex: "pt_BR")
  static ContentTimeInfo getContentTimeInfo(
    DateTime createdAt, {
    DateTime? editedAt,
    DateTime? ntpTime,
    String? locale,
  }) {
    final effectiveLocale = locale ?? Platform.localeName;

    final timeSinceCreated = formatTimeAgo(
      createdAt,
      referenceTime: ntpTime,
      locale: effectiveLocale,
    );

    final timeSinceEdited =
        editedAt != null
            ? formatTimeAgo(
              editedAt,
              referenceTime: ntpTime,
              locale: effectiveLocale,
            )
            : null;

    final formattedCreatedTime = formatDateTime(
      createdAt,
      locale: effectiveLocale,
    );

    return ContentTimeInfo(
      timeSinceCreated: timeSinceCreated,
      timeSinceEdited: timeSinceEdited,
      formattedCreatedTime: formattedCreatedTime,
    );
  }
}

/// Contém informações de tempo formatadas para exibição de conteúdo
class ContentTimeInfo {
  /// Texto formatado indicando quanto tempo se passou desde a criação
  /// (ex: "há 5 minutos")
  final String timeSinceCreated;

  /// Texto formatado indicando quanto tempo se passou desde a edição
  /// Null se o conteúdo nunca foi editado
  final String? timeSinceEdited;

  /// Data e hora de criação formatadas no padrão local
  /// (ex: "23/06/2024 15:30")
  final String formattedCreatedTime;

  /// Cria uma instância com informações de tempo para um conteúdo
  const ContentTimeInfo({
    required this.timeSinceCreated,
    this.timeSinceEdited,
    required this.formattedCreatedTime,
  });
}
