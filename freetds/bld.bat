set CMAKE_GENERATOR=NMake Makefiles JOM
mkdir build
cd build

cmake -G "%CMAKE_GENERATOR%" ^
         -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
         -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
         -DCMAKE_BUILD_TYPE=Release ^
         -DBUILD_SHARED_LIBS=True ..

cmake --build . --config Release --target all
cmake --build . --config Release --target install
