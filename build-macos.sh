# Turn off Mac OS verbose logging
export NSUnbufferedIO=NO

# Check if the build directory exists
if [ ! -d "build" ]; then
  echo "Creating build directory and copying .dylib files..."
  mkdir -p build

  # Copy .dylib files from vendor to build directory
  cp -P vendor/SDL3/macos/lib/*.dylib build/
  cp -P vendor/SDL3_ttf/macos/lib/*.dylib build/
fi

g++ -g -Wno-switch \
  -I vendor/SDL3/macos/include -L vendor/SDL3/macos/lib \
  -I vendor/SDL3_ttf/macos/include -L vendor/SDL3_ttf/macos/lib \
  -o build/sdl_snake_game \
  src/main.cpp \
  -lSDL3 -lSDL3_ttf \
  -Wl,-headerpad_max_install_names  # Increase header padding for install_name_tool

# SDL3
install_name_tool -add_rpath @executable_path/../vendor/SDL3/macos/lib build/sdl_snake_game

# SDL3_ttf
# SDL3_ttf
install_name_tool -add_rpath @executable_path/../vendor/SDL3_ttf/macos/lib build/sdl_snake_game
# Correct library reference to match actual file
install_name_tool -change @rpath/libSDL3_ttf.0.dylib @rpath/libSDL3_ttf.0.0.0.dylib build/sdl_snake_game