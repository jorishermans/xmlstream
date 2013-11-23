library xml_stream;

import 'dart:async';

part 'src/xml_char.dart';
part 'xml/xml_event.dart';
part 'xml/xml_state.dart';
part 'xml/xml_streamer.dart';
part 'xml/xml_processor.dart';

void main() {
  print("Hello, World!");
  
  var rawText = '<?xml version="1.0" encoding="UTF-8"?><hello attr="flow">world</hello>';
  
  var xmlStreamer = new XmlStreamer(rawText);
  
  xmlStreamer.read().listen((e) => print("listen: $e"));
}
