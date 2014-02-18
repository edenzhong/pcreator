#include "gtest/gtest.h"

TEST(sample_test_case, sample_test)
{    
	EXPECT_EQ(1,1);
}

int main(int argc,char** argv)
{     
	testing::InitGoogleTest(&argc, argv);
	int ret = RUN_ALL_TESTS();
	//std::getchar();// keep console window open until Return keystroke
	return 0;
}