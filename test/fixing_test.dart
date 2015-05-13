import 'package:test/test.dart';
import 'package:xmlstream/xmlstream.dart';
import 'dart:async';

main() {  
  group('fixing issues', () {
    // First tests!  
    var rawText = '''<required/>''';
      
      var states = [XmlState.StartDocument, XmlState.Open, XmlState.Closed, XmlState.EndDocument];
      var values = ["","required", "required", ""];
      int count = 0;
      
      test('using a string', () {
        var c = new Completer();
        var xmlStreamer = new XmlStreamer(rawText);
        xmlStreamer.read().listen((e) {
          expect(e.state, states[count]);
          expect(e.value, values[count]);
          count++;
        }, onDone: () {
          c.complete();
        });
        return c.future;
      });
    });
}
// <stream:stream from="gmail.com" id="E4AD98B517F8B666" version="1.0" xmlns:stream="http://etherx.jabber.org/streams" xmlns="jabber:client">
// <stream:features><starttls xmlns="urn:ietf:params:xml:ns:xmpp-tls"><required/></starttls><mechanisms xmlns="urn:ietf:params:xml:ns:xmpp-sasl"><mechanism>X-OAUTH2</mechanism><mechanism>X-GOOGLE-TOKEN</mechanism></mechanisms></stream:features>