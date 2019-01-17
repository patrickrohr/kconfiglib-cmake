# kconfiglib-cmake
CMake Package Module for Kconfiglib.

The following CMake targets are currently supported:
- `menuconfig`
- `genconfig`

More will come shortly.

## Quick Start
Set the following CMake variables to configure the package:

- `Kconfiglib_CONFIG_DIR`: Directory containing the Configuration file. Default: `CMAKE_SOURCE_DIR`
- `Kconfiglib_CONFIG_FILENAME`: Configuration file name. Default: `Kconfig`
- `Kconfiglib_DOT_CONFIG_DIR`: Directory where the .config file is saved. Default: `Kconfiglib_CONFIG_DIR`
- `Kconfiglib_HEADER_OUTPUT`: Output directory where the generated `config.h` should be placed. Default: `CMAKE_BINARY_DIR`
