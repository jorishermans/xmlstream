part of xml_stream;

class XmlStreamer {
  static const EMPTY = '';
  
  String raw;
  StreamController<XmlEvent> _controller;
  bool _shutdown = false;
  
  XmlStreamer(this.raw);
  
  Stream<XmlEvent> read() {
    _controller = new StreamController<XmlEvent>();
    
    XmlEvent event = new XmlEvent(XmlState.Top);
    String prev;
    var chars_raw = this.raw.split("");
    for (var ch in chars_raw) {
      switch(ch) {
        case XmlChar.LT:
          if (event.state != null && event.value.trim().isNotEmpty) {
            _controller.add(event);
          }
          event = createXmlEvent(XmlState.Open);
          break;
        case XmlChar.GT:
          _controller.add(event);
          event = createXmlEvent(XmlState.Text);
          break;
        case XmlChar.SLASH:
          event = createXmlEvent(XmlState.Closed);
          break;
        case XmlChar.SPACE:
          if (event.state == XmlState.Open || event.state == XmlState.Attribute) {
            _controller.add(event);
            event = createXmlEvent(event.state);
          } else {
            var value = event.value;
            event.value = "$value$ch";
          }
          break;
        case XmlChar.EQUALS:
          var value = event.value;
          if (event.state == XmlState.Open) {
            event = createXmlEvent(XmlState.Attribute);
            event.key = value;
          } else {
            event.value = "$value$ch";
          }
          break;
        case XmlChar.QUESTIONMARK:
          event = createXmlEvent(XmlState.Top);
          break;
        case XmlChar.SINGLE_QUOTES:
          break;
        case XmlChar.DOUBLE_QUOTES:
          break;
        case XmlChar.NEWLINE:
          break;
        default:
          var value = event.value;
          event.value = "$value$ch";
      }
      prev = ch;
      if (_shutdown) break;
    }
    return _controller.stream;
  }

  XmlEvent createXmlEvent(XmlState state) {
    XmlEvent event = new XmlEvent(state);
    event..value=EMPTY
         ..key=EMPTY;
    return event;
  }
  
  void shutdown() { _shutdown = true; }
}
