import 'package:test/test.dart';
import 'package:xmlstream/xmlstream.dart';

main() {  
  // First tests!  
  var rawText = '<b>bold</b> <i>italic</i>';
    
    var states = [XmlState.StartDocument, XmlState.Open, XmlState.Text, XmlState.Closed, XmlState.Text, XmlState.Open, XmlState.EndDocument];
    var values = ["", "b", "bold", "b", " ", "i", "italic", "i", ""];
    int count = 0;
    
    test('basic xml streaming', () {
      var xmlStreamer = new XmlStreamer(rawText, trimSpaces: false);
      xmlStreamer.read().listen((e) {
        expect(e.state, states[count]);
        expect(e.value, values[count]);
        count++;
      });
    });
}