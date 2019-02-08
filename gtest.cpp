////////////////////////////////////////////////////////////////////////////////
//   File      : getst.cpp
//   Contents  :
//
// Author(s) : FGR
// $LastChangedBy$
// $LastChangedDate$
// $Revision$
//
//-----------------------------------------------------------------------------
// LGPL V3.0 - https://www.gnu.org/licenses/lgpl-3.0.txt
//-----------------------------------------------------------------------------
////////////////////////////////////////////////////////////////////////////////
#include "App.h"
#include <gtest/gtest.h>

TEST(test_case_name, test_name)
{
	App();
	ASSERT_TRUE(  1 == 1 );
}

int main(int argc, char **argv)
{
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
