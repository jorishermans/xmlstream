import 'package:unittest/unittest.dart';
import 'package:xmlstream/xmlstream.dart';

main() {  
  // First tests!  
  var rawText = '''<?xml version="1.0" encoding="UTF-8"?>
                      <hello attr="flow">
                        <item>
                          <subitem>internal</subitem>
                          <subitem>hello</subitem>
                        </item>
                        <item>This is a sentence!</item>
                       </hello>''';
    
    var states = [XmlState.Top ,XmlState.Open, XmlState.Attribute, XmlState.Open, XmlState.Open, XmlState.Text, XmlState.Closed, XmlState.Open, XmlState.Text, XmlState.Closed, XmlState.Closed, XmlState.Open, XmlState.Text, XmlState.Closed, XmlState.Closed];
    var values = ["","hello","flow","item","subitem","internal","subitem","subitem","hello","subitem","item","item","This is a sentence!","item","hello"];
    int count = 0;
    
    var xmlStreamer = new XmlStreamer(rawText);
    xmlStreamer.read().listen((e) {
      test('basic xml streaming $e', () {
        expect(states[count], e.state);
        expect(values[count], e.value);
        count++;
      });
    });
}