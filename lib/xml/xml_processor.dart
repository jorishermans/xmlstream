part of xml_stream;

abstract class XmlProcessor<T> {
  
  T element;
  StreamController<T> _controller;
  
  XmlProcessor() {
    _controller = new StreamController<T>();
  }
  
  void onOpenTag(String tag);
  
  void onClosedTag(String tag) {
    _controller.add(element);
  }
  
  void onAttribute(String key, String value);

  void onText(String text);
  
  Stream<T> onProcess() {
    return _controller.stream;
  }
}