# Turn off Mac OS verbose logging
export NSUnbufferedIO=NO

# Check if the build directory exists
if [ ! -d "build" ]; then
  echo "Creating build directory and copying .dylib files..."
  mkdir -p build

  # Copy .dylib files from vendor to build directory
  cp -P vendor/SDL3/macos/lib/*.dylib build/
fi

g++ -g -Wno-switch -I vendor/SDL3/macos/include -L vendor/SDL3/macos/lib -o build/sdl_snake_game src/main.cpp -lSDL3

# SDL3
install_name_tool -add_rpath @executable_path/../vendor/SDL3/macos/lib build/sdl_snake_game