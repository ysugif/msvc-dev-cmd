


clone_libportaudio:
	mkdir -p libs \
	&& ( cd libs \
		&& ( rm -rf portaudio \
			&& git clone --recursive https://github.com/PortAudio/portaudio.git \
		) \
	)

config_libportaudio:
	( cd libs/portaudio  \
		&& rm -rf build \
		&& mkdir -p build \
		&& ( cd build \
			&& cmake .. \
				-G "Unix Makefiles" \
				-DCMAKE_INSTALL_PREFIX=`pwd`/../install \
				-DPA_BUILD_EXAMPLES=on \
				-DPA_BUILD_TESTS=on \
				-DPA_USE_ASIO=on \
		) \
	)


#				-G "Visual Studio 17 2022" \
#				-G "Unix Makefiles" \
#


build_libportaudio:
	( cd libs/portaudio ; \
		mkdir -p build \
		&& ( cd build ; \
			make ; \
			make install ; \
		) \
	)

show_padevice:
	( cd libs/portaudio/build/examples \
		&& ls -la \
		&& ./pa_devs \
	)


show_asio:
	( cd libs/portaudio/build/examples \
		&& ./paex_mono_asio_channel_select \
	)


ARTIFACTS_DIR=ci_artifacts
CI_ARTIFACTS_SUFFIX=Windows-X64

archive_libs:
	( tar -cf - libs) \
	| ( cd $(ARTIFACTS_DIR) \
		&& tar -xvf - \
	)


archive_artifacts :
	( uname -a | tee $(ARTIFACTS_DIR)/uname.txt )
	( git log | head -1 | tee $(ARTIFACTS_DIR)/commit_id.txt )
	$(MAKE) libarchive
	tar -czvf $(ARTIFACTS_DIR)-$(CI_ARTIFACTS_SUFFIX).tgz \
		$(ARTIFACTS_DIR)


check :
	$(MAKE) config_libportaudio
	$(MAKE) archive_libs
	$(MAKE) archive_artifacts
	$(MAKE) build_libportaudio
	$(MAKE) show_padevice
	#$(MAKE) show_asio
	cl.exe hello.c
	cl.exe -I./libs hello2.cpp
	#hello.exe
	#hello.exe | hello2.exe

