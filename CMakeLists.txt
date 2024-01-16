cmake_minimum_required(VERSION 3.10)

project(cli VERSION 0.1)

add_executable(cli cli.cpp cli.hpp)

set_target_properties(cli PROPERTIES RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)