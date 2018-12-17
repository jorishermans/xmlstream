part of xml_stream;

abstract class XmlParentProcessor<T> extends XmlProcessor<T> {
  
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
  
  void shouldAttribute(String key, String value) {
    super.shouldAttribute(key, value);
    for (XmlProcessor child in _children) {
      child.shouldAttribute(key, value);
    };
  }

  void shouldCharacters(String text) {
    super.shouldCharacters(text);
    for (XmlProcessor child in _children) {
      child.shouldCharacters(text);
    };
  }
}