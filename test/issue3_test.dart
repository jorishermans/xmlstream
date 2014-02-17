import 'package:unittest/unittest.dart';
import 'package:xmlstream/xmlstream.dart';

main() {  
  // First tests!  
  var rawText = '''<item name="NameAttr" >
                      <subitem>Test</subitem>
                   </item>''';
    
    var states = [XmlState.StartDocument, XmlState.Open, XmlState.Attribute, XmlState.Open, XmlState.Text, XmlState.Closed, XmlState.Closed, XmlState.EndDocument];
    var values = ["", "item", "NameAttr", "subitem", "Test", "subitem", "item", ""];
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