part of xml_stream;

class XmlObjectBuilder<T> {
  
  XmlStreamer _xmlStream;
  XmlProcessor<T> _xmlProcessor;
  
  XmlObjectBuilder(this._xmlStream, this._xmlProcessor) {
    _xmlStream.read().listen(_onListen);
  }
  
  _onListen(XmlEvent e) {
    if (e.state==XmlState.Open) {
      _xmlProcessor.shouldOpenTag(e.value);
    } else if (e.state == XmlState.Closed) {
      _xmlProcessor.shouldClosedTag(e.value);
    } else if (e.state == XmlState.Attribute) {
      _xmlProcessor.shouldAttribute(e.key, e.value);
    } else if (e.state == XmlState.Text) {
      _xmlProcessor.shouldCharacters(e.value);
    } else if (e.state == XmlState.CDATA) {
      _xmlProcessor.shouldCharacters(e.value);
    } else if (e.state == XmlState.EndDocument) {
      _onFinishedEvent.signal();
    }
  }
  
  Stream<T?> onProcess() {
    return _xmlProcessor.onProcess();
  }
  
  final EventStream _onFinishedEvent = new EventStream();
  Stream? get onFinished => _onFinishedEvent.stream;
  
  void shutdown() {
    _xmlStream.shutdown();
  }
  
}