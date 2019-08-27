import 'dart:async';

class BaseBlocModel<T> {
  BaseBlocModel() {
    _actionController.stream.listen(updateStream);
  }

  final StreamController _streamController = StreamController<T>.broadcast();
  Stream<T> get stream => _streamController.stream;

  final StreamController _actionController = StreamController<T>();
  StreamSink<T> get sink => _actionController.sink;

  void updateStream(T t) {
    _streamController.sink.add(t);
  }

  dispose() {
    _streamController.close();
    _actionController.close();
  }
}
