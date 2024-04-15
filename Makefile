


clone_libportaudio:
	mkdir -p libs \
	&& ( cd libs \
		&& ( rm -rf portaudio \
			&& git clone --recursive https://github.com/PortAudio/portaudio.git \
		) \
	)

config_libportaudio:
	( cd libs/portaudio  \
		&& rm -rf buildXcode \
		&& mkdir -p buildXcode \
		&& ( cd buildXcode \
			&& cmake .. \
				-G Xcode \
				-DCMAKE_INSTALL_PREFIX=`pwd`/../install \
				-DPA_BUILD_EXAMPLES=on \
				-DPA_BUILD_TESTS=on \
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
	$(MAKE) config_libportaudio
	$(MAKE) build_libportaudio
	cl.exe hello.c
	cl.exe hello2.cpp
	#hello.exe
	#hello.exe | hello2.exe

