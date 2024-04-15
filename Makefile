


clone_libportaudio:
	mkdir -p libs \
	&& ( cd libs \
		&& ( rm -rf portaudio \
			&& git clone --recursive https://github.com/PortAudio/portaudio.git \
		) \
	)

build_libportaudio:
	( cd libs/portaudio ; \
		mkdir -p build \
		&& ( cd build ; \
			make ; \
			make install ; \
		) \
	)


check :
	$(MAKE) build_libportaudio
	cl.exe hello.c
	cl.exe hello2.cpp
	#hello.exe
	#hello.exe | hello2.exe

