#/**************************************************************
# *                                                            *
# *               Copyright (c) 2019 - Patrick Rohr            *
# *                      All Rights Reserved                   *
# *                                                            *
# *************************************************************/

# CMake Find Module for Kconfiglib: https://github.com/ulfalizer/Kconfiglib
# TODO: Adapt to follow official CMake Style Guide
cmake_minimum_required(VERSION 3.0.2)

################################################################
# Input Variables
################################################################
if(NOT DEFINED Kconfiglib_CONFIG_DIR)
    set(Kconfiglib_CONFIG_DIR ${CMAKE_SOURCE_DIR})
endif()

if(NOT DEFINED Kconfiglib_DOT_CONFIG_DIR)
    set(Kconfiglib_DOT_CONFIG_DIR ${Kconfiglib_CONFIG_DIR})
endif()

if(NOT DEFINED Kconfiglib_CONFIG_FILENAME)
    set(Kconfiglib_CONFIG_FILENAME "Kconfig")
endif()

if(NOT DEFINED Kconfiglib_HEADER_OUTPUT)
    set(Kconfiglib_HEADER_OUTPUT ${CMAKE_BINARY_DIR})
endif()


include(ExternalProject)

find_package(Python3 QUIET)

if(NOT ${Python3_FOUND})
    find_package(Python2 REQUIRED)
endif()

ExternalProject_Add(
    Kconfiglib_Download
    GIT_REPOSITORY https://github.com/ulfalizer/Kconfiglib
    GIT_TAG master
    CONFIGURE_COMMAND ""
    BUILD_COMMAND ""
    INSTALL_COMMAND ""
    UPDATE_COMMAND ""
    LOG_DOWNLOAD ON
)

ExternalProject_Get_Property(Kconfiglib_Download SOURCE_DIR)

set(Kconfiglib_Download_SOURCE_DIR ${SOURCE_DIR})
set(ENV{srctree} ${Kconfiglib_CONFIG_DIR})
set(ENV{KCONFIG_CONFIG} ${Kconfiglib_DOT_CONFIG_DIR})

if(${Python3_FOUND})
    add_custom_target(menuconfig
        COMMAND ${Python3_EXECUTABLE} ${Kconfiglib_Download_SOURCE_DIR}/menuconfig.py
            ${Kconfiglib_CONFIG_DIR}/${Kconfiglib_CONFIG_FILENAME}
    )
    set(Python_EXECUTABLE ${Python3_EXECUTABLE})
endif()


if("${Python2_FOUND}" OR "${Python3_FOUND}")
    if(NOT DEFINED Python_EXECUTABLE)
        set(Python_EXECUTABLE ${Python2_EXECUTABLE})
    endif()

    add_custom_target(genconfig
        COMMAND ${Python_EXECUTABLE} ${Kconfiglib_Download_SOURCE_DIR}/genconfig.py
            --header-path ${Kconfiglib_HEADER_OUTPUT}/config.h
            ${Kconfiglib_CONFIG_DIR}/${Kconfiglib_CONFIG_FILENAME}
    )

    # TODO: Support all targets
endif()

find_package_handle_standard_args(Kconfiglib
    FOUND_VAR Kconfiglib_FOUND
    REQUIRED_VARS Python_EXECUTABLE Kconfiglib_Download_SOURCE_DIR
    # TODO: Versioning
)

add_dependencies(menuconfig Kconfiglib_Download)
add_dependencies(genconfig Kconfiglib_Download)
