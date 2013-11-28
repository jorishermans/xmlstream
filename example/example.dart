import 'package:xmlstream/xmlstream.dart';

void main() {
  print("Hello, World!");
  
  var rawText = '<?xml version="1.0" encoding="UTF-8"?><hello attr="flow" url="http://static2.demorgen.be/static/photo/2013/5/14/9/20131127210358/media_s_6291969.jpg">world</hello><hello attr="link">http://www.demorgen.be/dm/nl/1005/Meer-Sport/article/detail/1748285/2013/11/27/Scheenbeenbreuk-voor-wereldkampioen-hink-stap-springen.dhtml/</hello><end attr="flow" />';
  
  var xmlStreamer = new XmlStreamer(rawText);
  
  xmlStreamer.read().listen((e) => print("listen: $e"));
}