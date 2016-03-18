project("image-selection")
cmake_minimum_required(VERSION 2.8)

#set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")

find_package(opencv 3 REQUIRED)
include_directories(&{OpenCV_INCLUDE_DIRS})

if(NOT DEFINED REPO_DIR)
	set(REPO_DIR ${CMAKE_SOURCE_DIR})
endif()

if(NOT DEFINED DETECTION_MANAGER_DIR)
	set(DETECTION_MANAGER_DIR ${ADM_DIR})
endif()

message(${DETECTION_MANAGER_DIR})

if (NOT EXISTS "${DETECTION_MANAGER_DIR}/CMakeLists.txt")
	message(FATAL_ERROR
	"Admobilize detection manager repo was not found. Please "
	"define path to your repositories as REPO_DIR variable "
	"or explicit path to admobilize detection manager as DET_MANAGER_DIR variable")
endif()


add_subdirectory(
	${DETECTION_MANAGER_DIR}
	detection-manager
)
include_directories(${DETECTION_MANAGER_DIR}/lib)
include(${DETECTION_MANAGER_DIR}/cmake/clandmark.cmake)

set(SRC
	face_detect.cpp
	main.cpp
)

add_executable(face-select ${SRC})
target_link_libraries(face-select
	adm-detection-manager
	${OpenCV_LIBS}
)