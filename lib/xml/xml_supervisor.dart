part of xml_stream;

class XmlSupervisor<T> {
  
  XmlStreamer _xmlStream;
  XmlProcessor<T> _xmlProcessor;
  
  XmlSupervisor(this._xmlStream, this._xmlProcessor) {
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
      _xmlProcessor.shouldText(e.value);
    } 
  }
  
  Stream<T> onProcess() {
    return _xmlProcessor.onProcess();
  }
  
  void shutdown() {
    _xmlStream.shutdown();
  }
  
}