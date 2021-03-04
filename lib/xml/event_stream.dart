part of xml_stream;

abstract class NotifyPropertyChanged {
  Stream<PropertyChangedEventArgs> get onPropertyChanged;
}

class EventStream<T> {
  StreamController<T?> _controller = StreamController<T>();
  Stream<T?>? stream;

  EventStream() {
    stream = _controller.stream.asBroadcastStream();
  }

  signal([T? value]) {
    _controller.add(value != null ? value : EventArgs.empty as T?);
  }
}

class EventArgs {
  static final EventArgs empty = EventArgs();
  EventArgs();
}

class PropertyChangedEventArgs<T> extends EventArgs {
  PropertyChangedEventArgs(String this.propertyName, T this.value);
  String propertyName;
  T value;
}