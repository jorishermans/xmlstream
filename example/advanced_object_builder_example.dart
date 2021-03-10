import 'package:xmlstream/xmlstream.dart';

void main() {
  print("Hello, World!"); 
  
  var rawText = '''<?xml version="1.0" encoding="UTF-8"?>
                     <outer name="outer">scope</sub>
                     <items>
                      <sub name="outer">scope</sub>                    
                      <item name="flow">
                        <sub name="one">hello</sub>
                        <sub name="two">world</sub>
                      </item>
                      <item name="text">say what</item>
                    </items>''';
  
  var xmlStreamer = new XmlStreamer(rawText);
  
  var xmlSupervisor = new XmlObjectBuilder<Item>(xmlStreamer, new ItemProcessor());
  
  xmlSupervisor.onProcess().listen((e) => print("listen: $e"));
}

class ItemProcessor extends XmlParentProcessor<Item> {
  SubItemProcessor? subItemProcessor;
  
  void registerProcessors() {
    subItemProcessor = new SubItemProcessor();
    subItemProcessor!.onProcess().listen((value) { 
      if (isScope()) element!.add(value); 
    });
    add(subItemProcessor);
  }
  
  ItemProcessor() {
    tagName = "item";
  }
  
  void onOpenTag(String? tag) {
     element = new Item();
  }
  
  void onAttribute(String? key, String? value) {
    if (key == "name") {
      element!.name = value;
    }
  }

  void onCharacters(String? text) {} 
}

class SubItemProcessor extends XmlProcessor<SubItem> {
  
  SubItemProcessor() {
    tagName = "sub";
  }
  
  void onOpenTag(String? tag) {
     element = new SubItem();
  }
  
  void onAttribute(String? key, String? value) {
    if (key == "name") {
      element!.name = value;
    }
  }

  void onCharacters(String? text) {
      element!.value = text;
  } 
}

class Item {
  String? name;
  List<SubItem?> subItems = List<SubItem?>.empty(growable: true);
  
  void add(SubItem? subItem) => subItems.add(subItem);
  
  String toString() => "$name --> $subItems";
}

class SubItem {
  String? name;
  String? value;
  
  String toString() => "$name - $value";
}