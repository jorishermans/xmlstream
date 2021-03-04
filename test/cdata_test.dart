import 'dart:async';

import 'package:test/test.dart';
import 'package:xmlstream/xmlstream.dart';

main() {
  var rawText = '''
<?xml version="1.0" encoding="UTF-8"?>
<item><![CDATA[One Two]]></item>''';
  var list = List<List<int>>.empty(growable: true);
  list.add(rawText.codeUnits);
  var stream = new Stream.fromIterable(list);

  var states = [XmlState.StartDocument, XmlState.Top, XmlState.Open,
    XmlState.CDATA, XmlState.Closed, XmlState.EndDocument];
  var values = ["", "", "item", "One Two", "item", ""];
  int count = 0;

  var xmlStreamer = new XmlStreamer.fromStream(stream);
  test('basic xml streaming', () {
    xmlStreamer.read().listen((e) {
      expect(e.state, states[count]);
      expect(e.value, values[count]);
      count++;
    });
  });
}
