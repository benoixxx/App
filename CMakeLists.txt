cmake_minimum_required(VERSION 3.5)

# =============
# == PROJECT ==
# =============
project(App VERSION 0.0.0 LANGUAGES CXX)

# ===========
# == FILES ==
# ===========

set( SOURCE_FILES
    App.cpp
)

set( INCLUDE_FILES
    App.h
)

# ===========================
# == EXTERNAL DEPENDENCIES ==
# ===========================

find_package(libC QUIET)

# ======================
# == BUILD DIRECTIVES ==
# ======================
#
#Define the project target
#
add_executable(
    ${PROJECT_NAME}
    ${SOURCE_FILES}
    ${INCLUDE_FILES}
    main.cpp
)

#
# CFLAGS & CXXFLAGS
#
target_compile_options(
    ${PROJECT_NAME} PRIVATE
    -Wall -Wextra -fmessage-length=0
    $<$<CONFIG:DEBUG>:-O0 -ggdb>
    $<$<CONFIG:RELEASE>:-O3 -ggdb>
)

#
# Tell we need to use C++11
#
set_property(
    TARGET ${PROJECT_NAME}
    PROPERTY CXX_STANDARD 11
)

#
# -D
#
target_compile_definitions(
    ${PROJECT_NAME} PRIVATE
    $<$<CONFIG:DEBUG>:DEBUG=1>
    $<$<CONFIG:RELEASE>:NDEBUG=1>
)

#
# -I
#
target_include_directories(
    ${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}/..
)

#
# -l
#
target_link_libraries(
    ${PROJECT_NAME} PRIVATE
    C
)

#
# Strip
#
if (${CMAKE_BUILD_TYPE} STREQUAL "Release")

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD
    COMMAND ${CMAKE_OBJCOPY} --only-keep-debug ${PROJECT_NAME} ${PROJECT_NAME}.debug
    COMMAND ${CMAKE_OBJCOPY} --strip-debug ${PROJECT_NAME}
    COMMAND ${CMAKE_OBJCOPY} --add-gnu-debuglink=${PROJECT_NAME}.debug ${PROJECT_NAME}
)

endif()

# ==================
# == UNIT TESTING ==
# ==================
add_executable(
    UnitTest_${PROJECT_NAME}
    ${SOURCE_FILES}
    ${INCLUDE_FILES}
    gtest.cpp
)

find_package(GTest REQUIRED)
find_package(Threads REQUIRED)

target_include_directories(
    UnitTest_${PROJECT_NAME} PRIVATE
    ${CMAKE_CURRENT_SOURCE_DIR}
    ${GTEST_INCLUDE_DIRS}
)

target_link_libraries(
    UnitTest_${PROJECT_NAME}
    ${GTEST_BOTH_LIBRARIES}
    ${CMAKE_THREAD_LIBS_INIT}
    C
)

# ========================
# == INSTALL DIRECTIVES ==
# ========================

install(TARGETS ${PROJECT_NAME} DESTINATION bin)

if (${CMAKE_BUILD_TYPE} STREQUAL "Release")
    install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}.debug DESTINATION bin)
endif()
