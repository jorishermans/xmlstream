part of xml_stream;

class XmlStreamer {
  static const EMPTY = '';
  
  Stream<List<int>> stream;
  String raw;
  String _open_value;
  
  String special_char;
  
  StreamController<XmlEvent> _controller;
  
  bool _shutdown = false;
  
  XmlStreamer(this.raw);
  
  XmlStreamer.fromStream(this.stream);
  
  Stream<XmlEvent> read() {
    _controller = new StreamController<XmlEvent>();
    XmlEvent event = createAndAddXmlEvent(XmlState.StartDocument);
  
    String prev;
    if (this.stream == null) {
      var chars_raw = this.raw.split("");
      for (var ch in chars_raw) {
        event = _processRawChar(ch, prev, event);
        prev = ch;
        if (_shutdown) break;
      }
      createAndAddXmlEvent(XmlState.EndDocument);
      _controller.close();
    } else {
      StreamSubscription controller;
      var onData = (data) {
        var chars_raw = new String.fromCharCodes(data).split("");
        for (var ch in chars_raw) {
          event = _processRawChar(ch, prev, event);
          prev = ch;
          if (_shutdown) {
            controller.cancel();
            break;
          }
        }
      };
      controller = stream.listen(onData,
          onDone: () {
            createAndAddXmlEvent(XmlState.EndDocument);
            _controller.close();
          });
    }

    return _controller.stream;
  }
  
  XmlEvent _processRawChar(var ch, var prev, XmlEvent event) {
    switch(ch) {
      case XmlChar.LT:
        if (event.state != null && event.value.trim().isNotEmpty) {
          _addElement(event);
        }
        event = _createXmlEvent(XmlState.Open);
        break;
      case XmlChar.GT:
        if (prev == XmlChar.SLASH) {
          if ((event.value.length > 0) && (event.value.length -1) == event.value.lastIndexOf("/")) {
            event.value = event.value.substring(0, event.value.lastIndexOf("/"));
          }
          event = _createXmlEventAndCheck(event, XmlState.Closed);
          event.value = _open_value;
        }
        _addElement(event);
        event = _createXmlEvent(XmlState.Text);
        break;
      case XmlChar.SLASH:
        if (event.state != XmlState.Open) { 
          event = addCharToValue(event, ch);
        } else if (prev == XmlChar.LT) {
          event = _createXmlEvent(XmlState.Closed);
        }
        break;
      case XmlChar.SPACE:
        if (event.state == XmlState.Open && event.value == '!--') {
          event = _createXmlEvent(XmlState.Comment);
        } else if (event.state == XmlState.Open) {
          _addElement(event);
          event = _createXmlEvent(event.state);
          event.fired = true;
        } else if (event.state == XmlState.Attribute) {
          if (!event.fired && special_char != null) {
            event = addCharToValue(event, ch);
          }
        } else {
          event = addCharToValue(event, ch);
        }
        break;
      case XmlChar.EQUALS:
        var value = event.value;
        if (event.state == XmlState.Open) {
          event = _createXmlEventAndCheck(event, XmlState.Attribute);
          event.key = value;
        } else if (event.state == XmlState.Attribute && special_char == null) {
          event = _createXmlEvent(XmlState.Attribute);
          event.key = value;
        } else {
          event.value = "$value$ch";
        }
        break;
      case XmlChar.DASH:
        if (event.state != XmlState.Comment) {
          event = addCharToValue(event, ch);
        }
        break;
      case XmlChar.QUESTIONMARK:
        if (prev == XmlChar.LT || event.state == XmlState.Top || event.state == XmlState.StartDocument) {
          event = _createXmlEvent(XmlState.Top);
        } else {
          event = addCharToValue(event, ch);
        }
        break;
      case XmlChar.SINGLE_QUOTES:
        if (event.state == XmlState.Attribute) {
          event = _quotes_handling(ch, event);
        } 
        break;
      case XmlChar.DOUBLE_QUOTES:
        if (event.state == XmlState.Attribute) {
          event = _quotes_handling(ch, event);
        }
        break;
      case XmlChar.NEWLINE:
        break;
      default:
        event = addCharToValue(event, ch);
    }
    return event;
  }
  
  XmlEvent _quotes_handling(String ch, XmlEvent event) {
    if (special_char == null) {
      special_char = ch;
    } else if (special_char == ch) {
      _addElement(event);
      event = _createXmlEvent(event.state);
      
      special_char = null;
    }
    
    return event;
  }
  
  XmlEvent _addElement(XmlEvent event) {
    if (_shouldAdd(event)) { 
      _controller.add(event); 
      event.fired = true;
    }
    if (event.state == XmlState.Open) {
      _open_value = event.value;
    } 
    
    return event;
  }
  
  bool _shouldAdd(XmlEvent event) {
    if (event.state == XmlState.Attribute || 
        event.state == XmlState.Open || 
        event.state == XmlState.Closed) {
        if (event.key == "" && event.value == "") {
          return false;
        }
        if (event.fired) {
          return false;
        }
    }
    return true;
  }
  
  XmlEvent addCharToValue(XmlEvent event, String ch) {
    var value = event.value;
    event.value = "$value$ch";
    return event;
  }

  XmlEvent createAndAddXmlEvent(XmlState state) {
    XmlEvent event = _createXmlEvent(state);
      _controller.add(event);
    event.fired = true;
    return event;
  }
  
  XmlEvent _createXmlEventAndCheck(XmlEvent event, XmlState state) {
    if (event.fired == false) {
      _addElement(event);
    }
    return _createXmlEvent(state);
  }
  
  XmlEvent _createXmlEvent(XmlState state) {
    XmlEvent event = new XmlEvent(state);
    event..value=EMPTY
         ..key=EMPTY;
    return event;
  }
  
  void shutdown() { _shutdown = true; }
}
