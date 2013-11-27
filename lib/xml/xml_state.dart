part of xml_stream;

class XmlState {
  final String _type;

  const XmlState(this._type);

  static const Open = const XmlState('Open');
  static const Top = const XmlState('Top');
  static const Closed = const XmlState('Closed');
  static const Attribute = const XmlState('Attribute');
  static const Text = const XmlState('Text');
  static const Namespace = const XmlState('Namespace');
  static const CDATA = const XmlState('CDATA');
  static const Comment = const XmlState('Comment');
  static const StartDocument = const XmlState('StartDocument');
  static const EndDocument = const XmlState('EndDocument');

  String toString() => _type;
}