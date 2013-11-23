part of xml_stream;

abstract class XmlProcessor<T> {
  
  T element;
  
  void onStartTag(String tag, String name);
  
  void onEndTag(String tag, String name);
  
  void onAttribute(String key, String value);

}