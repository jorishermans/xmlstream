import 'package:unittest/unittest.dart';
import 'package:xmlstream/xmlstream.dart';
import 'dart:io';
import 'dart:async';

main() {  
  group('reading xml', () {
    // First tests!  
    var rawText = '''<?xml version="1.0" encoding="UTF-8"?>
                        <hello attr="flow">
                          <item>
                            <subitem>internal</subitem>
                            <subitem>hello</subitem>
                          </item>
                          <item>This is a sentence!</item>
                         </hello>''';
      
      var states = [XmlState.StartDocument, XmlState.Top ,XmlState.Open, XmlState.Attribute, XmlState.Open, XmlState.Open, XmlState.Text, XmlState.Closed, XmlState.Open, XmlState.Text, XmlState.Closed, XmlState.Closed, XmlState.Open, XmlState.Text, XmlState.Closed, XmlState.Closed, XmlState.EndDocument];
      var values = ["", "","hello","flow","item","subitem","internal","subitem","subitem","hello","subitem","item","item","This is a sentence!","item","hello",""];
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
      
      test('using a stream', () {
        var c = new Completer();
        var streamCount = 0;
        var stream = new File("./test1.xml").openRead(); 
        var xmlStreamer = new XmlStreamer.fromStream(stream);
        xmlStreamer.read().listen((e) {
          expect(e.state, states[streamCount]);
          expect(e.value, values[streamCount]);
          streamCount++;
        }, onDone: () {
          c.complete();
        });
        return c.future;
      });
  });
}