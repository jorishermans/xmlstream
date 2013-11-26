## xmlstream ##

A lightweight api for parsing xml

You can listen to xml encounters and states by parsing the xml char by char.

### Simple usage ###

The xmlStreamer will send an XmlEvent that will contain the state and value of a specific part of the xml.

See here a simple example how to use it in your application.

	var xmlStreamer = new XmlStreamer(rawText);
	xmlStreamer.read().listen((e) => print("listen: $e"));
	
These are the xml states:

* Top
* Open
* Closed
* Attribute
* Characters

Namespace and cdate are still on the todo list to support!

### Object builder usage ###

In this package we provide also the opportunity to build and stream Objects.

If we have the following xml:

	<?xml version="1.0" encoding="UTF-8"?>
	<item name="flow">world</item>
	<item name="text">say what</item>

You see an item object in it. So we want to pump the data in the following object.

	class Item {
	  String name;
	  String value;
  
	  String toString() => "$name - $value";
	}
	
You can do that by creating a class that extends from XmlProcessor<Item>.

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
	
Now bootstrap the processing and you are ready to build a list of Items.

	var xmlStreamer = new XmlStreamer(rawText);
	var xmlObjectBuilder = new XmlObjectBuilder<Item>(xmlStreamer, new ItemProcessor());
	xmlObjectBuilder.onProcess().listen((e) => print("listen: $e"));

The listen method will produce Item objects and you can listen to the production of it.
If you want to parse an hierachical object structure then you can take a look at XmlParentProcessor class.

In my project on github you will find some examples how to use it. Any suggestions for improvements are welcome.

### Ideas ###

It is based upon the SAX's and StAX's principles from Java. 

### Contributing ###
 
If you found a bug, just create a new issue or even better fork and issue a
pull request with you fix.