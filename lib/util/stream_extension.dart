import 'dart:async';

import 'package:flutter/material.dart';

extension MapNotNullStreamExt<T> on Stream<T> {
  Stream<R> mapNotNull<R>(R Function(T) mapper) {
    return transform(StreamTransformer<T, R>.fromHandlers(
      handleData: (data, sink) {
        final mapped = mapper(data);
        if (mapped != null) {
          sink.add(mapped);
        }
      },
      handleError: (e, st, sink) => sink.addError(e, st),
      handleDone: (sink) => sink.close(),
    ));
  }
}

extension DebugMapStreamsExtension on Map<String, Stream<dynamic>> {
  List<StreamSubscription> debug() => entries
      .map((entry) => entry.value
          .listen((data) => debugPrint('[DEBUG] [${entry.key}] = $data')))
      .toList();
}
