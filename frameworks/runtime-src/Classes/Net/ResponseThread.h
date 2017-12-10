//
//  ResponseThread.hpp
//  slot-mobile
//
//  Created by GongYan on 2017/12/9.
//

#ifndef ResponseThread_hpp
#define ResponseThread_hpp

#include <stdio.h>
#include <pthread.h>
#include "ODSocket.h"
#include "cocos2d.h"
#include "BaseRequestMsg.h"
typedef void (cocos2d::Ref:: *ResponseThreadEvent)(BaseRequestMsg*);
#define callFunc_selectormsg(_SELECTOR) (ResponseThreadEvent)(&_SELECTOR)

#define M_ADDCALLBACKEVENT(varName)\
protected: cocos2d::Ref* m_##varName##listener;ResponseThreadEvent varName##selector;\
public: void add##varName##ListenerEvent(ResponseThreadEvent m_event,cocos2d::Ref* listener)  { m_##varName##listener=listener;varName##selector=m_event; }

class ResponseThread
{
public:
    ~ResponseThread();
    static ResponseThread* GetInstance();
    int start(void* = NULL);
    void stop();
    void sleep(int tesec);
    void detach();
    void *wait();
    
private:
    ResponseThread();
    pthread_t handle;
    bool started;
    bool detached;
    static void* threadFunc(void*);
    static ResponseThread* m_pInstance;
    M_ADDCALLBACKEVENT(msg);
    M_ADDCALLBACKEVENT(notcon);
};

#endif /* ResponseThread_hpp */
