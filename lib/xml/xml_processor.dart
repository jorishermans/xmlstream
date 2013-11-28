part of xml_stream;

abstract class XmlProcessor<T> {
  
  T element;
  StreamController<T> _controller;
  
  String tagName;
  String currentTag;
  String scopedTag;
  
  XmlProcessor() {
    _controller = new StreamController<T>(); 
  }
  
  void shouldOpenTag(String tag) {
    if (tagName==tag) {
      onOpenTag(tag);
      scopedTag=tag;
    } else if (isScope()) {
      onScopedTag(tag);
    }
    currentTag=tag;
  }
  
  void shouldClosedTag(String tag) {
    if (tagName==tag) {
      onClosedTag(tag);
      scopedTag="";
    }
  }
  
  void shouldAttribute(String key, String value) {
    if (element!=null && isOnCurrentTag()) {
      this.onAttribute(key, value);
    }
  }
  
  void shouldCharacters(String text) {
    if (element != null) {
      if (isOnCurrentTag()) {
        this.onCharacters(text);
      } else if (isScope()) {
        this.onScopedCharacters(text);
      }
    }
  }
  
  void onOpenTag(String tag);
  
  void onScopedTag(String tag) {}
  void onScopedCharacters(String text) {}
  
  void onClosedTag(String tag) {
    _controller.add(element);
  }
  
  void onAttribute(String key, String value) {}
  void onCharacters(String text) {}
  
  bool isScope() => scopedTag == tagName;
  bool isOnCurrentTag() => currentTag == tagName;
  
  Stream<T> onProcess() {
    return _controller.stream;
  }
}