//
//  SocketThread.cpp
//  slot-mobile
//
//  Created by GongYan on 2017/12/9.
//

#include "cocos2d.h"
#include "SocketThread.h"
USING_NS_CC;

int SocketThread::start(){
    int errCode = 0;
    do{
        pthread_attr_t tAttr;
        errCode = pthread_attr_init(&tAttr);
        CC_BREAK_IF(errCode != 0);
        errCode = pthread_attr_setdetachstate(&tAttr, PTHREAD_CREATE_DETACHED);
        if (errCode != 0){
            pthread_attr_destroy(&tAttr);
            break;
        }
        errCode = pthread_create(&pid, &tAttr, start_thread, this);
    }while(0);
    return errCode;
}

void* SocketThread::start_thread(void* arg)
{
    SocketThread* thred = (SocketThread*)arg;
    ODSocket cdSocket;
    cdSocket.Init();
    bool isok =cdSocket.Create(AF_INET, SOCK_STREAM,0);
    bool iscon = cdSocket.Connect("127.0.0.1", 8888);
    if(iscon)
    {
        thred->state = 0;
        
    }
    else
    {
        thred->state = 1;
    }
    thred->csocket = cdSocket;
    return NULL;
}

ODSocket SocketThread::getSocket()
{
    return this->csocket;
}

SocketThread* SocketThread::m_pInstance = new SocketThread;
SocketThread* SocketThread::GetInstance()
{
    return m_pInstance;
}

void SocketThread::stop()
{
    pthread_cancel(pid);
    pthread_detach(pid);
}

SocketThread::SocketThread(void)
{
    
}

SocketThread::~SocketThread()
{
    if(m_pInstance != NULL)
    {
        delete m_pInstance;
    }
}
