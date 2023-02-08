cmake_minimum_required(VERSION 3.10.0 FATAL_ERROR)

project(
  dy
  VERSION 1.0
  DESCRIPTION "dy"
  LANGUAGES C)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(Python3 REQUIRED COMPONENTS Interpreter Development)
message("Python3_EXECUTABLE: ${Python3_EXECUTABLE}")
message("Python3_SITEARCH: ${Python3_SITEARCH}")
message("Python3_LIBRARIES: ${Python3_LIBRARIES}")
message("Python3_INCLUDE_DIRS: ${Python3_INCLUDE_DIRS}")

include_directories(${Python3_INCLUDE_DIRS})
add_library(eval_frame SHARED ptdynamo/eval_frame.c)
target_link_libraries(eval_frame ${Python3_LIBRARIES})
SET_TARGET_PROPERTIES(eval_frame PROPERTIES PREFIX "")
install(TARGETS eval_frame LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX})
