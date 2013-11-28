import 'package:xmlstream/xmlstream.dart';

void main() {
  print("Hello, World!");
  
  var rawText = '<?xml version="1.0" encoding="UTF-8"?><hello attr="flow">world</hello><hello attr="link">http://www.demorgen.be/dm/nl/1005/Meer-Sport/article/detail/1748285/2013/11/27/Scheenbeenbreuk-voor-wereldkampioen-hink-stap-springen.dhtml</hello>';
  
  var xmlStreamer = new XmlStreamer(rawText);
  
  xmlStreamer.read().listen((e) => print("listen: $e"));
}