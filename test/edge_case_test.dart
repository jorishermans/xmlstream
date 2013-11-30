import 'package:unittest/unittest.dart';
import 'package:xmlstream/xmlstream.dart';

main() {  
  // First tests!  
  var rawText = '<end attr="flow"/>';
    
    var states = [XmlState.StartDocument, XmlState.Open, XmlState.Attribute, XmlState.Closed, XmlState.EndDocument];
    var values = ["", "end", "flow", "end", ""];
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