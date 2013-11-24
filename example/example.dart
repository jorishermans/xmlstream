import 'package:xmlstream/xmlstream.dart';

void main() {
  print("Hello, World!");
  
  var rawText = '<?xml version="1.0" encoding="UTF-8"?><hello attr="flow">world</hello>';
  
  var xmlStreamer = new XmlStreamer(rawText);
  
  xmlStreamer.read().listen((e) => print("listen: $e"));
}