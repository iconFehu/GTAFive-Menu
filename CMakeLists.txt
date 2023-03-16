# CMakeLists.txt
cmake_minimum_required(VERSION 3.0)
set(CMAKE_TOOLCHAIN_FILE $ENV{VCPKG_ROOT}/scripts/buildsystems/vcpkg.cmake)
set(VCPKG_TARGET_TRIPLET x64-windows-static-md)
project(test)

# main target
add_executable(main)
target_sources(main PRIVATE src/main.cpp)
target_link_libraries(main PRIVATE unofficial::sqlite3::sqlite3 fmt::fmt)

# Find dependencies provided by vcpkg (via vcpkg.cmake)
find_package(unofficial-sqlite3 CONFIG REQUIRED)
find_package(fmt CONFIG REQUIRED)

find_package(minhook CONFIG REQUIRED)
target_link_libraries(main PRIVATE minhook::minhook)

find_package(cpr CONFIG REQUIRED)
target_link_libraries(main PRIVATE cpr::cpr)

find_package(imgui CONFIG REQUIRED)
target_link_libraries(main PRIVATE imgui::imgui)

set(OpenCV_DIR "${VCPKG_INSTALLED_DIR}/x64-windows-static-md/share/opencv4")
find_package(OpenCV REQUIRED)

find_package(pugixml CONFIG REQUIRED)
target_link_libraries(main PRIVATE pugixml::static pugixml::pugixml)


set_property(TARGET main PROPERTY CXX_STANDARD 20)

# tests target
#add_executable(tests)
#target_sources(tests PRIVATE src/main.cpp)
#target_link_libraries(tests PRIVATE unofficial::sqlite3::sqlite3 fmt::fmt)
#set_property(TARGET tests PROPERTY CXX_STANDARD 20)
#enable_testing()
#add_test(tests tests)