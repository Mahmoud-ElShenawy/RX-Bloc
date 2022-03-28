import 'package:rxdart/rxdart.dart';

class GlobalBloc {
  ///
  /// Streams related to this BLoC
  ///
  final BehaviorSubject<String> _controller = BehaviorSubject<String>();

  Function(String) get push => _controller.sink.add;

  Stream<String> get stream => _controller;

  ///
  /// Singleton factory
  ///
  static final GlobalBloc _bloc = GlobalBloc._internal();

  factory GlobalBloc() {
    return _bloc;
  }

  GlobalBloc._internal();

  ///
  /// Resource disposal
  ///
  void dispose() {
    _controller.close();
  }
}

GlobalBloc globalBloc = GlobalBloc();
