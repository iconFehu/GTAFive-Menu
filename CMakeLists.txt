# CMakeLists.txt
cmake_minimum_required(VERSION 3.0)
set(CMAKE_TOOLCHAIN_FILE $ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake)
set(VCPKG_TARGET_TRIPLET x64-windows-static-md)
project(YimMenu)

set(SRC_DIR "${PROJECT_SOURCE_DIR}/src")

# Git commit embed
include(scripts/git.cmake)

# YimMenu
message(STATUS "YimMenu")
file(GLOB_RECURSE SRC_MAIN
        "${SRC_DIR}/**.hpp"
        "${SRC_DIR}/**.h"
        "${SRC_DIR}/**.cpp"
        "${SRC_DIR}/**.cc"
        "${SRC_DIR}/**.cxx"
        "${SRC_DIR}/**.asm"
        )
add_library(YimMenu MODULE "${SRC_MAIN}")

#add_executable(YimMenu)
#target_sources(YimMenu PRIVATE src/*)
target_link_libraries(YimMenu PRIVATE unofficial::sqlite3::sqlite3 fmt::fmt)

# Find dependencies provided by vcpkg (via vcpkg.cmake)
find_package(unofficial-sqlite3 CONFIG REQUIRED)
find_package(fmt CONFIG REQUIRED)

find_package(minhook CONFIG REQUIRED)
target_link_libraries(YimMenu PRIVATE minhook::minhook)

find_package(cpr CONFIG REQUIRED)
target_link_libraries(YimMenu PRIVATE cpr::cpr)

find_package(imgui CONFIG REQUIRED)
target_link_libraries(YimMenu PRIVATE imgui::imgui)

find_package(nlohmann_json CONFIG REQUIRED)
target_link_libraries(YimMenu PRIVATE nlohmann_json::nlohmann_json)

set(OpenCV_DIR "${VCPKG_INSTALLED_DIR}/x64-windows-static-md/share/opencv4")
find_package(OpenCV REQUIRED)

find_package(pugixml CONFIG REQUIRED)
target_link_libraries(YimMenu PRIVATE pugixml::static pugixml::pugixml)


set_property(TARGET YimMenu PROPERTY CXX_STANDARD 23) # 23 Because std::format is not avalible in std:c++20 for some reason. Maybe it's because i use v142 toolset.


# tests target
#add_executable(tests)
#target_sources(tests PRIVATE src/YimMenu.cpp)
#target_link_libraries(tests PRIVATE unofficial::sqlite3::sqlite3 fmt::fmt)
#set_property(TARGET tests PROPERTY CXX_STANDARD 20)
#enable_testing()
#add_test(tests tests)

# Fetch modules
message("\nFetching modules")
include(scripts/async-logger.cmake)
include(scripts/zydis.cmake)

message("\nFetching custom modules")
include(scripts/gtav-classes.cmake)


target_include_directories(YimMenu PRIVATE
        "${SRC_DIR}"
        "${json_SOURCE_DIR}/single_include"
        "${gtav_classes_SOURCE_DIR}"
        "${imgui_SOURCE_DIR}"
        )

target_precompile_headers(YimMenu PRIVATE "${SRC_DIR}/common.hpp")
target_link_libraries(YimMenu PRIVATE AsyncLogger dbghelp)