import 'dart:async';

import 'package:unittest/unittest.dart';
import 'package:xmlstream/xmlstream.dart';

main() {
  var rawText = '''
<?xml version="1.0" encoding="UTF-8"?>
<item><![CDATA[One Two]]></item>''';
  var list = new List<List<int>>();
  list.add(rawText.codeUnits);
  var stream = new Stream.fromIterable(list);

  var states = [XmlState.StartDocument, XmlState.Top, XmlState.Open,
    XmlState.CDATA, XmlState.Closed, XmlState.EndDocument];
  var values = ["", "", "item", "One Two", "item", ""];
  int count = 0;

  var xmlStreamer = new XmlStreamer.fromStream(stream);
  xmlStreamer.read().listen((e) {
    test('basic xml streaming $e', () {
      expect(e.state, states[count]);
      expect(e.value, values[count]);
      count++;
    });
  });
}
