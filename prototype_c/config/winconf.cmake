message(status "winconf.cmake")

SET(EXTRA_INCLUDES 
	
	)
SET(EXTRA_LIBS
	
	)

SET(REQUIRED_LIBRARIES
	
   )

SET(TEST_INCLUDES 
	"$ENV{GMOCK_DIR}/include"
	"$ENV{GTEST_DIR}/include"
	)
SET(TEST_LIBS
	"$ENV{GMOCK_DIR}/build"
	)

SET(TEST_REQUIRED_LIBRARIES
     #gmock
   )

#   link_directories(${EXTRA_LIBS} ${CMAKE_LIBRARY_OUTPUT_DIRECTORY})