import 'package:xmlstream/xmlstream.dart';

void main() {
  print("Making sure that quotes are not ignored when placed within text.");

  var rawText = '<?xml version="1.0" encoding="UTF-8"?><root>This is some "text" and the owner\'s looking for it.</root>';

  var xmlStreamer = new XmlStreamer(rawText);

  xmlStreamer.read().listen((e) => print("listen: $e"));
}
