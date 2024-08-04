GNATMAKE=gnatmake
GPRBUILD=gprbuild

printself: src/printself.adb
	$(GNATMAKE) $? -o bin/$@ -D bin/

server: src/server.adb server.gpr
	$(GPRBUILD) -P server.gpr

pointers: src/pointers.adb
	$(GNATMAKE) $? -o bin/$@ -D bin/
