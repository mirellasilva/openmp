cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

set(OPENMP_LLVM_TOOLS_DIR "" CACHE PATH "Path to LLVM tools for testing")

add_subdirectory(runtime)

# Currently libomptarget cannot be compiled on Windows.
# Since the device plugins are only supported on Linux anyway,
# there is no point in trying to compile libomptarget on other OSes.
if (NOT WIN32)
  add_subdirectory(libomptarget)
endif()

