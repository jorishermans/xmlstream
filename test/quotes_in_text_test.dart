import "package:test/test.dart";
import 'package:xmlstream/xmlstream.dart';

main() {
  // First tests!
  var rawText = '<?xml version="1.0" encoding="UTF-8"?><text>"bonjour" is "hello" in French, et "c\'est utile de le savoir" means "it is useful to know it"</text><hello attr="flow">world</hello><text>Did you know that "text" is "texte" in French?</text>';

  var states = [XmlState.StartDocument, XmlState.Top, XmlState.Open, XmlState.Text, XmlState.Closed, XmlState.Open, XmlState.Attribute, XmlState.Text, XmlState.Closed, XmlState.Open, XmlState.Text, XmlState.Closed, XmlState.EndDocument];
  var values = ["", "", "text", '"bonjour" is "hello" in French, et "c\'est utile de le savoir" means "it is useful to know it"', "text", "hello", "world", "hello", "text", 'Did you know that "text" is "texte" in French?', "text", ""];
  int count = 0;

  var xmlStreamer = new XmlStreamer(rawText);
  test('quotes in text', () {
    xmlStreamer.read().listen((e) {
      expect(e.state, states[count]);
      expect(e.value, values[count]);
      count++;
    });
  });
}
