import 'package:test/test.dart';
import 'package:xmlstream/xmlstream.dart';

void main() {
  test('testing end result items', () {
    var rawText = '<?xml version="1.0" encoding="UTF-8"?><item name="flow">world</item><item name="text">say what?</item>';
    
    var xmlStreamer = new XmlStreamer(rawText);
    
    var xmlObjectBuilder = new XmlObjectBuilder<Item>(xmlStreamer, new ItemProcessor());
    
    List<Item?> items = List<Item?>.empty(growable: true);
    xmlObjectBuilder.onProcess().listen((data) => items.add(data), // output the data
        onError: (error) => print("Error, could not open file"),
        onDone: () => print("Finished reading data")); 
    
    xmlObjectBuilder.onFinished!.listen((_) {
        expect(items.length, 2);
        expect(items.first!.name, "flow");
        expect(items.last!.value, "say what?");
      });
  });
}

class ItemProcessor extends XmlProcessor<Item> {
  
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

  void onCharacters(String? text) {
    element!.value = text;
  } 
}

class Item {
  String? name;
  String? value;
  
  String toString() => "$name - $value";
}

