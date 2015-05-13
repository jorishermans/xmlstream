import 'package:test/test.dart';
import 'package:xmlstream/xmlstream.dart';

main() {  
  // First tests!  
  var rawText = '<item name="jack" type="string">42</item>';
    
    var states = [XmlState.StartDocument, XmlState.Open, XmlState.Attribute, XmlState.Attribute, XmlState.Text, XmlState.Closed, XmlState.EndDocument];
    var values = ["", "item", "jack", "string", "42", "item", ""];
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