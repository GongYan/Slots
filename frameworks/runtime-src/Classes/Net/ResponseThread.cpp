//
//  ResponseThread.cpp
//  slot-mobile
//
//  Created by GongYan on 2017/12/9.
//

#include "ResponseThread.h"
#include "SocketThread.h"

ResponseThread* ResponseThread::m_pInstance = new ResponseThread;
ResponseThread* ResponseThread::GetInstance()
{
    return m_pInstance;
}

ResponseThread::ResponseThread()
{
    this->m_msglistener = NULL;
    started = detached = false;
}

ResponseThread::~ResponseThread()
{
    stop();
}

int ResponseThread::start(void* param)
{
    int errCode = 0;
    do{
        pthread_attr_t attributes;
        errCode = pthread_attr_init(&attributes);
        CC_BREAK_IF(errCode!= 0);
        errCode = pthread_attr_setdetachstate(&attributes, PTHREAD_CREATE_DETACHED);
        if(errCode !=0){
            pthread_attr_destroy(&attributes);
            break;
        }
        errCode = pthread_create(&handle, &attributes, threadFunc, this);
        started = true;
    }while (0);
    return errCode;
}

void* ResponseThread::threadFunc(void * arg)
{
    ResponseThread* thred = (ResponseThread*)arg;
    ODSocket csocket = SocketThread::GetInstance()->getSocket();
    if (SocketThread::GetInstance()->state == 0)
    {
        while (true) {
            
        }
    }
}

