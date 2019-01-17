# kconfiglib-cmake
CMake Find Module for Kconfiglib: https://github.com/ulfalizer/Kconfiglib

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

## Example

    # CMakeLists.txt
    list(APPEND CMAKE_MODULE_PATH "${CMAKE_SOURCE_DIR}/path-to-FindKconfiglib-cmake")

    set(Kconfiglib_CONFIG_DIR "${CMAKE_SOURCE_DIR}/path-to-your-Kconfig-file")
    set(Kconfiglib_CONFIG_FILENAME "AlternativeNameForKconfig")
    set(Kconfiglib_HEADER_OUTPUT "${CMAKE_BINARY_DIR}/path-to-your-config-header-output")

    find_package(Kconfiglib REQUIRED)
