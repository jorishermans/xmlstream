## xmlstream ##

A lightweight api for parsing xml

You can listen to xml encounters and states by parsing the xml char by char.

### Simple usage ###

The xmlStreamer will send an XmlEvent that will contain the state and value of a specific part of the xml.

See here a simple example how to use it in your application.

	var xmlStreamer = new XmlStreamer(rawText);
	xmlStreamer.read().listen((e) => print("listen: $e"));

### Contributing ###
 
If you found a bug, just create a new issue or even better fork and issue a
pull request with you fix.