part of xml_stream;

class XmlEvent {
  XmlState state;
  String key;
  String value;
  
  XmlEvent(this.state, {this.key : "", this.value : ""});
  
  String toString() => "$state, [$key] $value";
}