//
//  Test.hpp
//  slot-mobile
//
//  Created by GongYan on 2017/12/8.
//

#ifndef Test_hpp
#define Test_hpp

#include <stdio.h>
#include "ODSocket.h"
#include <pthread.h>

class Test
{
public:
    void connectServer();
    void receiveData();
    
private:
    ODSocket socket;
    
};
#endif /* Test_hpp */
