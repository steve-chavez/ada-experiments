GNATMAKE=gnatmake

printself: src/printself.adb
	$(GNATMAKE) $? -o bin/$@ -D bin/
