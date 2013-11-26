part of xml_stream;

abstract class XmlParentProcessor<T> extends XmlProcessor {
  
  List<XmlProcessor> _children = new List<XmlProcessor>();
  
  XmlParentProcessor() {
    registerProcessors();
  }
  
  void registerProcessors();
  
  void add(XmlProcessor xmlProcessor) {
    _children.add(xmlProcessor);
  }
  
  void shouldOpenTag(String tag) {
    super.shouldOpenTag(tag);
    for (XmlProcessor child in _children) {
      child.shouldOpenTag(tag);
    };
  }
  
  void shouldClosedTag(String tag) {
    super.shouldClosedTag(tag);
    for (XmlProcessor child in _children) {
      child.shouldClosedTag(tag);
    };
  }
  
  void onAttribute(String key, String value) {
    for (XmlProcessor child in _children) {
      child.onAttribute(key, value);
    };
  }

  void onText(String text) {
    for (XmlProcessor child in _children) {
      child.onText(text);
    };
  }
}