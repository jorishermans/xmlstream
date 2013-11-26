import 'package:xmlstream/xmlstream.dart';

void main() {
  print("Hello, World!");
  
  var rawText = '<?xml version="1.0" encoding="UTF-8"?><item name="flow">world</item><item name="text">say what</item>';
  
  var xmlStreamer = new XmlStreamer(rawText);
  
  var xmlObjectBuilder = new XmlObjectBuilder<Item>(xmlStreamer, new ItemProcessor());
  
  xmlObjectBuilder.onProcess().listen((e) => print("listen: $e"));
}

class ItemProcessor extends XmlProcessor<Item> {
  
  ItemProcessor() {
    tagName = "item";
  }
  
  void onOpenTag(String tag) {
     element = new Item();
  }
  
  void onAttribute(String key, String value) {
    if (key == "name") {
      element.name = value;
    }
  }

  void onCharacters(String text) {
    element.value = text;
  } 
}

class Item {
  String name;
  String value;
  
  String toString() => "$name - $value";
}

