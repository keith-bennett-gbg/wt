# Find Wt includes and libraries
#
# This module reads hints about search locations from variables::
#
#  Wt_ROOT             - Preferred installation prefix
#
# This script sets the following variables:
#
#  Wt_INCLUDE_DIR
#  Wt_LIBRARIES        - Release libraries
#  Wt_FOUND            - True if release libraries found
#  Wt_DEBUG_LIBRARIES  - Debug libraries
#  Wt_DEBUG_FOUND      - True if debug libraries found
#
# To direct the script to a particular Wt installation, use the
# standard cmake variables CMAKE_INCLUDE_PATH and CMAKE_LIBRARY_PATH
#
# To use this script to find Wt, when using the new style for include files:
#   #include <Wt/WLineEdit>
#   #include <Wt/Ext/LineEdit>
#   #include <Wt/Chart/WPieChart>
#
# include the following CMake snippet in your project:
#
#  FIND_PACKAGE( Wt REQUIRED )
#  INCLUDE_DIRECTORIES( ${Wt_INCLUDE_DIR} )
#  TARGET_LINK_LIBRARIES( yourexe
#    ${Wt_DEBUG_LIBRARY}        # or {Wt_LIBRARY}
#    ${Wt_HTTP_DEBUG_LIBRARY}   # or {Wt_HTTP_LIBRARY}
#    ${Wt_EXT_DEBUG_LIBRARY}    # or {Wt_EXT_LIBRARY}
#  )
#
# To use this script to find Wt, when using the old include style:
#   #include <WLineEdit>
#   #include <Ext/LineEdit>
#   #include <Chart/WPieChart>
# style of include files, change the INCLUDE_DIRECTORIES statement to:
#   INCLUDE_DIRECTORIES( ${Wt_INCLUDE_DIR} ${Wt_INCLUDE_DIR}/Wt )
#
#
#
#
# Copyright (c) 2007, Pau Garcia i Quiles, <pgquiles@elpauer.org>
#
# Redistribution and use is allowed according to the terms of the BSD license.
# For details see the accompanying COPYING-CMAKE-SCRIPTS file.

# If -DWt_ROOT was not passed to cmake, then check environment variables.
IF(NOT Wt_ROOT)
  SET(Wt_ROOT "$ENV{Wt_ROOT}")
ENDIF()
IF(NOT "${Wt_ROOT}" STREQUAL "")
  IF(NOT Wt_FIND_QUIETLY)
    MESSAGE(STATUS "Searching for Wt in ${Wt_ROOT}")
  ENDIF()
ENDIF()

FIND_PATH( Wt_INCLUDE_DIR NAMES Wt/WObject PATHS ${Wt_ROOT} PATH_SUFFIXES include wt )

SET( Wt_FIND_COMPONENTS Release Debug )

FIND_LIBRARY( Wt_LIBRARY NAMES wt PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-release lib_release )
FIND_LIBRARY( Wt_EXT_LIBRARY NAMES wtext PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-release lib_release )
FIND_LIBRARY( Wt_HTTP_LIBRARY NAMES wthttp PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-release lib_release )
FIND_LIBRARY( Wt_TEST_LIBRARY NAMES wttest PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-release lib_release )
FIND_LIBRARY( Wt_FCGI_LIBRARY NAMES wtfcgi PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-release lib_release )
FIND_LIBRARY( Wt_DBO_LIBRARY NAMES wtdbo PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-release lib_release )
FIND_LIBRARY( Wt_DBOSQLITE3_LIBRARY NAMES wtdbosqlite3 PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-release lib_release )
FIND_LIBRARY( Wt_DBOPOSTGRES_LIBRARY NAMES wtdbopostgres PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-release lib_release )
FIND_LIBRARY( Wt_DBOMYSQL_LIBRARY NAMES wtdbomysql PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-release lib_release )
FIND_LIBRARY( Wt_DBOFIREBIRD_LIBRARY NAMES wtdbofirebird PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-release lib_release )

FIND_LIBRARY( Wt_DEBUG_LIBRARY NAMES wtd wt PATHS ${Wt_ROOT} PATH_SUFFIXES lib libd lib-debug lib_debug HINTS /usr/lib/debug/usr/lib)
FIND_LIBRARY( Wt_EXT_DEBUG_LIBRARY NAMES wtextd wtext PATHS ${Wt_ROOT} PATH_SUFFIXES lib libd lib-debug lib_debug HINTS /usr/lib/debug/usr/lib)
FIND_LIBRARY( Wt_HTTP_DEBUG_LIBRARY NAMES wthttpd wthttp PATHS ${Wt_ROOT} PATH_SUFFIXES lib libd lib-debug lib_debug HINTS /usr/lib/debug/usr/lib)
FIND_LIBRARY( Wt_TEST_DEBUG_LIBRARY NAMES wttestd wttest PATHS ${Wt_ROOT} PATH_SUFFIXES lib libd lib-debug lib_debug HINTS /usr/lib/debug/usr/lib)
FIND_LIBRARY( Wt_FCGI_DEBUG_LIBRARY NAMES wtfcgid wtfcgi PATHS ${Wt_ROOT} PATH_SUFFIXES lib libd lib-debug lib_debug HINTS /usr/lib/debug/usr/lib)
FIND_LIBRARY( Wt_DBO_DEBUG_LIBRARY NAMES wtdbod wtdbo PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-debug lib_debug HINTS /usr/lib/debug/usr/lib)
FIND_LIBRARY( Wt_DBOSQLITE3_DEBUG_LIBRARY NAMES wtdbosqlite3d wtdbosqlite3 PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-debug lib_debug HINTS /usr/lib/debug/usr/lib)
FIND_LIBRARY( Wt_DBOPOSTGRES_DEBUG_LIBRARY NAMES wtdbopostgresd wtdbopostgres PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-debug lib_debug HINTS /usr/lib/debug/usr/lib)
FIND_LIBRARY( Wt_DBOMYSQL_DEBUG_LIBRARY NAMES wtdbomysqld wtdbomysql PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-debug lib_debug HINTS /usr/lib/debug/usr/lib)
FIND_LIBRARY( Wt_DBOFIREBIRD_DEBUG_LIBRARY NAMES wtdbofirebirdd wtdbofirebird PATHS ${Wt_ROOT} PATH_SUFFIXES lib lib-debug lib_debug HINTS /usr/lib/debug/usr/lib)

IF( Wt_LIBRARY )
    IF( Wt_HTTP_LIBRARY )
        SET( Wt_FOUND TRUE )
        SET( Wt_FIND_REQUIRED_Release TRUE )
        SET( Wt_LIBRARIES ${Wt_HTTP_LIBRARY} ${Wt_LIBRARY} )

        IF( Wt_FCGI_LIBRARY )
            SET( Wt_LIBRARIES ${Wt_LIBRARIES} ${Wt_FCGI_LIBRARY} )
        ENDIF( Wt_FCGI_LIBRARY )
    ELSE( Wt_HTTP_LIBRARY )
        IF( Wt_FCGI_LIBRARY )
            SET( Wt_FOUND TRUE )
            SET( Wt_FIND_REQUIRED_Release TRUE )
            SET( Wt_LIBRARIES ${Wt_FCGI_LIBRARY} ${Wt_LIBRARY} )
        ENDIF( Wt_FCGI_LIBRARY )
    ENDIF( Wt_HTTP_LIBRARY )
ENDIF( Wt_LIBRARY )

IF( Wt_EXT_LIBRARY )
    SET( Wt_LIBRARIES ${Wt_LIBRARIES} ${Wt_EXT_LIBRARY} )
ENDIF( Wt_EXT_LIBRARY )

IF( Wt_DBO_LIBRARY )
    SET( Wt_LIBRARIES ${Wt_LIBRARIES} ${Wt_DBO_LIBRARY} )
    IF( Wt_DBOSQLITE3_LIBRARY )
        SET( Wt_LIBRARIES ${Wt_LIBRARIES} ${Wt_DBOSQLITE3_LIBRARY} )
    ENDIF( Wt_DBOSQLITE3_LIBRARY )
    IF( Wt_DBOPOSTGRES_LIBRARY )
        SET( Wt_LIBRARIES ${Wt_LIBRARIES} ${Wt_DBOPOSTGRES_LIBRARY} )
    ENDIF( Wt_DBOPOSTGRES_LIBRARY )
    IF( Wt_DBOMYSQL_LIBRARY )
        SET( Wt_LIBRARIES ${Wt_LIBRARIES} ${Wt_DBOMYSQL_LIBRARY} )
    ENDIF( Wt_DBOMYSQL_LIBRARY )
    IF ( Wt_DBOFIREBIRD_LIBRARY )
        SET ( Wt_LIBRARIES ${Wt_LIBRARIES} ${Wt_DBOFIREBIRD_LIBRARY} )
    ENDIF ( Wt_DBOFIREBIRD_LIBRARY )
ENDIF( Wt_DBO_LIBRARY )

IF( Wt_DEBUG_LIBRARY )
    IF ( Wt_HTTP_DEBUG_LIBRARY)
        SET( Wt_DEBUG_FOUND TRUE )
        SET( Wt_FIND_REQUIRED_Debug TRUE )
        SET( Wt_DEBUG_LIBRARIES ${Wt_HTTP_DEBUG_LIBRARY} ${Wt_DEBUG_LIBRARY} )

        IF( Wt_FCGI_DEBUG_LIBRARY )
            SET( Wt_DEBUG_LIBRARIES ${Wt_DEBUG_LIBRARIES} ${Wt_FCGI_DEBUG_LIBRARY} )
        ENDIF( Wt_FCGI_DEBUG_LIBRARY )
        ELSE( Wt_HTTP_DEBUG_LIBRARY )
            IF( Wt_FCGI_DEBUG_LIBRARY )
                SET( Wt_DEBUG_FOUND TRUE )
                SET( Wt_FIND_REQUIRED_Debug TRUE )
                SET( Wt_DEBUG_LIBRARIES ${Wt_FCGI_DEBUG_LIBRARY} ${Wt_DEBUG_LIBRARY} )
            ENDIF( Wt_FCGI_DEBUG_LIBRARY )
        ENDIF( Wt_HTTP_DEBUG_LIBRARY)       
ENDIF( Wt_DEBUG_LIBRARY )

IF( Wt_DBO_DEBUG_LIBRARY )
    SET( Wt_DEBUG_LIBRARIES ${Wt_DEBUG_LIBRARIES} ${Wt_DBO_DEBUG_LIBRARY} )
    IF( Wt_DBOSQLITE3_DEBUG_LIBRARY )
        SET( Wt_DEBUG_LIBRARIES ${Wt_DEBUG_LIBRARIES} ${Wt_DBOSQLITE3_DEBUG_LIBRARY} )
    ENDIF( Wt_DBOSQLITE3_DEBUG_LIBRARY )
    IF( Wt_DBOPOSTGRES_DEBUG_LIBRARY )
        SET( Wt_DEBUG_LIBRARIES ${Wt_DEBUG_LIBRARIES} ${Wt_DBOPOSTGRES_DEBUG_LIBRARY} )
    ENDIF( Wt_DBOPOSTGRES_DEBUG_LIBRARY )
    IF( Wt_DBOMYSQL_DEBUG_LIBRARY )
        SET( Wt_DEBUG_LIBRARIES ${Wt_DEBUG_LIBRARIES} ${Wt_DBOMYSQL_DEBUG_LIBRARY} )
    ENDIF ( Wt_DBOMYSQL_DEBUG_LIBRARY )
    IF ( Wt_DBOFIREBIRD_DEBUG_LIBRARY )
        SET (Wt_DEBUG_LIBRARIES ${Wt_DEBUG_LIBRARIES} ${Wt_DBOFIREBIRD_DEBUG_LIBRARY} )
    ENDIF ( Wt_DBOFIREBIRD_DEBUG_LIBRARY )
ENDIF( Wt_DBO_DEBUG_LIBRARY )

IF(Wt_FOUND)
    IF (NOT Wt_FIND_QUIETLY)
        MESSAGE(STATUS "Found the Wt libraries at ${Wt_LIBRARIES}")
        MESSAGE(STATUS "Found the Wt headers at ${Wt_INCLUDE_DIR}")
    ENDIF (NOT Wt_FIND_QUIETLY)
ELSE(Wt_FOUND)
    IF(Wt_FIND_REQUIRED)
        MESSAGE(FATAL_ERROR "Could NOT find Wt. You could try setting Wt_ROOT to your installation prefix.")
    ENDIF(Wt_FIND_REQUIRED)
ENDIF(Wt_FOUND)

IF(Wt_DEBUG_FOUND)
    IF (NOT Wt_FIND_QUIETLY)
        MESSAGE(STATUS "Found the Wt debug libraries at ${Wt_DEBUG_LIBRARIES}")
        MESSAGE(STATUS "Found the Wt debug headers at ${Wt_INCLUDE_DIR}")
    ENDIF (NOT Wt_FIND_QUIETLY)
ELSE(Wt_DEBUG_FOUND)
    IF(Wt_FIND_REQUIRED_Debug)
        MESSAGE(FATAL_ERROR "Could NOT find Wt debug libraries. You could try setting Wt_ROOT to your installation prefix.")
    ENDIF(Wt_FIND_REQUIRED_Debug)
ENDIF(Wt_DEBUG_FOUND)

