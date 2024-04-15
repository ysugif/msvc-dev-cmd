

check :
	cl.exe hello.c
	cl.exe hello2.cpp
	hello.exe
	hello.exe | hello2.exe

