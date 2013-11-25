part of xml_stream;

abstract class XmlProcessor<T> {
  
  T element;
  StreamController<T> _controller;
  
  String tagName;
  String scopedName;
  
  XmlProcessor() {
    _controller = new StreamController<T>(); 
  }
  
  void shouldOpenTag(String tag) {
    if (tagName==tag) {
      onOpenTag(tag);
    }
    scopedName=tag;
  }
  
  void onOpenTag(String tag);
  
  void shouldClosedTag(String tag) {
    if (tagName==tag) {
      onClosedTag(tag);
    }
  }
  
  void onClosedTag(String tag) {
    _controller.add(element);
  }
  
  void onAttribute(String key, String value);

  void onText(String text);
  
  bool isScope() => scopedName == tagName;
  
  Stream<T> onProcess() {
    return _controller.stream;
  }
}