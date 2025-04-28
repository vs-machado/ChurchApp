import 'package:church_app/core/domain/util/error.dart';
import 'package:flutter/material.dart';

import '../../../generated/l10n.dart';

enum NetworkError implements Error {
  requestTimeout,
  tooManyRequests,
  noInternetConnection,
  serverError,
  serialization,
  unknown,
}

extension ErrorMessage on NetworkError {
  String toErrorString(BuildContext context) {
    return switch (this) {
      NetworkError.requestTimeout => S.of(context).requestTimeout,
      NetworkError.tooManyRequests => S.of(context).tooManyRequests,
      NetworkError.noInternetConnection => S.of(context).noInternetConnection,
      NetworkError.serverError => S.of(context).serverError,
      NetworkError.serialization => S.of(context).somethingWentWrong,
      NetworkError.unknown => S.of(context).somethingWentWrong,
    };
  }
}
