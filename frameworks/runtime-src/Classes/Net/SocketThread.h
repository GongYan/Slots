//
//  SocketThread.hpp
//  slot-mobile
//
//  Created by GongYan on 2017/12/9.
//

#ifndef SocketThread_hpp
#define SocketThread_hpp

#include <stdio.h>
#include "ODSocket.h"
#include <pthread.h>
class SocketThread
{
public:
    ~SocketThread();
    static SocketThread* GetInstance();
    int start();
    ODSocket getSocket();
    int state;
    ODSocket csocket;
    void stop();
private:
    pthread_t pid;
    static void* start_thread(void*);
    SocketThread(void);
    static SocketThread* m_pInstance;
};

#endif /* SocketThread_hpp */
