import 'package:xmlstream/xmlstream.dart';

void main() {
  print("Hello, World!");
  
  var rawText = '''<?xml version="1.0" encoding="UTF-8"?>
                    <items>                    
                      <item name="flow">
                        <sub name="one">hello</sub>
                        <sub name="two">world</sub>
                      </item>
                      <item name="text">say what</item>
                    </items>''';
  
  var xmlStreamer = new XmlStreamer(rawText);
  
  var xmlSupervisor = new XmlSupervisor<Item>(xmlStreamer, new ItemProcessor());
  
  xmlSupervisor.onProcess().listen((e) => print("listen: $e"));
}

class ItemProcessor extends XmlProcessor<Item> {
  
  ItemProcessor() {
    tagName = "item";
  }
  
  void onOpenTag(String tag) {
     element = new Item();
  }
  
  void onAttribute(String key, String value) {
    if (key == "name" && isScope()) {
      element.name = value;
    }
  }

  void onText(String text) {} 
}

class Item {
  String name;
  
  String toString() => "$name";
}

class SubItem {
  String name;
  String value;
  
  String toString() => "$name - $value";
}