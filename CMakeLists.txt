cmake_minimum_required(VERSION 3.10.0 FATAL_ERROR)

project(
  dy
  VERSION 1.0
  DESCRIPTION "dy"
  LANGUAGES C CXX)

set(CMAKE_POSITION_INDEPENDENT_CODE ON)

find_package(Python3 REQUIRED COMPONENTS Interpreter Development)
message("Python3_EXECUTABLE: ${Python3_EXECUTABLE}")
message("Python3_SITEARCH: ${Python3_SITEARCH}")
message("Python3_LIBRARIES: ${Python3_LIBRARIES}")
message("Python3_INCLUDE_DIRS: ${Python3_INCLUDE_DIRS}")

include_directories(${Python3_INCLUDE_DIRS})

add_library(_eval_frame SHARED torchdynamo/_eval_frame.c)
target_link_libraries(_eval_frame ${Python3_LIBRARIES})
set_target_properties(_eval_frame PROPERTIES PREFIX "")
install(TARGETS _eval_frame LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX})

# find torch
execute_process(
  COMMAND ${Python3_EXECUTABLE} -c
          "import torch;print(torch.utils.cmake_prefix_path, end='')"
  WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
  OUTPUT_VARIABLE torch_cmake_prefix_path)
message("torch_cmake_prefix_path: ${torch_cmake_prefix_path}")
find_package(Torch REQUIRED PATHS ${torch_cmake_prefix_path})

add_library(_guards SHARED torchdynamo/_guards.cpp)
target_link_libraries(_guards ${Python3_LIBRARIES} torch)
set_target_properties(_guards PROPERTIES PREFIX "")
set_property(TARGET _guards PROPERTY CXX_STANDARD 14)
install(TARGETS _guards LIBRARY DESTINATION ${CMAKE_INSTALL_PREFIX})
