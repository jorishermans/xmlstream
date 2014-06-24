import 'package:unittest/unittest.dart';
import 'package:xmlstream/xmlstream.dart';

main() {  
  // First tests!  
  var rawText = '<?xml version="1.0" encoding="UTF-8"?><!--dit is een comment --><hello attr="flow">world</hello>';
    
    var states = [XmlState.StartDocument, XmlState.Top, XmlState.Comment, XmlState.Open, XmlState.Attribute, XmlState.Text, XmlState.Closed, XmlState.EndDocument];
    var values = ["", "","dit is een comment ", "hello", "flow","world", "hello", ""];
    int count = 0;
    
    var xmlStreamer = new XmlStreamer(rawText);
    xmlStreamer.read().listen((e) {
      test('basic xml streaming $e', () {
        expect(e.state, states[count]);
        expect(e.value, values[count]);
        count++;
      });
    });
}