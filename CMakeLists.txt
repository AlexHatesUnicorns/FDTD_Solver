CMAKE_MINIMUM_REQUIRED(VERSION 2.8)
SET(CMAKE_CXX_COMPILER clang++)
SET(CMAKE_C_COMPILER clang)
PROJECT(FDTD_solver)
FIND_PACKAGE(CUDA REQUIRED)

INCLUDE(FindCUDA)

SET(CUDA_SEPARABLE_COMPILATION ON)

INCLUDE_DIRECTORIES(/usr/local/cuda/include)

file(GLOB_RECURSE SOURCES "src/*.cpp" "src/*.cu" "src/*.h")
CUDA_ADD_EXECUTABLE(FDTD_Solver ${SOURCES})

SET(CMAKE_CXX_FLAGS "-w -std=c++11 -O3 -ffast-math")

LIST(APPEND CUDA_NVCC_FLAGS "—compiler-options; -fno-strict-aliasing; -lineinfo; -use_fast_math; -Xptxas")

MESSAGE(${CUDA_NVCC_FLAGS})

