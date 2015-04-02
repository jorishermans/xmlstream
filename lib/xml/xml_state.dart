part of xml_stream;

enum XmlState {
  Open, Top, Closed, Attribute, Text, Namespace, CDATA, Comment, StartDocument, EndDocument
}