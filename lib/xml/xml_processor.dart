part of xml_stream;

abstract class XmlProcessor<T> {
  
  T element;
  StreamController<T> _controller;
  
  String tagName;
  String currentTag;
  String scopedName;
  
  XmlProcessor() {
    _controller = new StreamController<T>(); 
  }
  
  void shouldOpenTag(String tag) {
    if (tagName==tag) {
      onOpenTag(tag);
      scopedName=tag;
    }
    currentTag=tag;
  }
  
  void shouldClosedTag(String tag) {
    if (tagName==tag) {
      onClosedTag(tag);
      scopedName="";
    }
  }
  
  void shouldAttribute(String key, String value) {
    if (isOnCurrentTag()) {
      this.onAttribute(key, value);
    }
  }
  
  void shouldCharacters(String text) {
    if (isOnCurrentTag()) {
      this.onCharacters(text);
    }
  }
  
  void onOpenTag(String tag);
  void onClosedTag(String tag) {
    _controller.add(element);
  }
  
  void onAttribute(String key, String value);
  void onCharacters(String text);
  
  bool isScope() => scopedName == tagName;
  bool isOnCurrentTag() => currentTag == tagName;
  
  Stream<T> onProcess() {
    return _controller.stream;
  }
}