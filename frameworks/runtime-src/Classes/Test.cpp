//
//  Test.cpp
//  slot-mobile
//
//  Created by GongYan on 2017/12/8.
//
#include "Test.hpp"
void Test::connectServer()
{
    socket.Init();
    socket.Create(AF_INET, SOCK_STREAM, 0);
    
    const char* ip = "127.0.0.1";
    int port = 12345;
    bool result = socket.Connect(ip, port);
    
    socket.Send("login", 5);
    
    if(result){
        CCLOG("connect to server success");
        std::thread recvThread = std::thread(&Test::receiveData,this);
        recvThread.detach();
    }
    else
    {
        CCLOG("can not connect to server");
        return;
    }
}
void Test::receiveData()
{
    while (true) {
        char data[512] = "";
        int result = socket.Recv(data, 512, 0);
        if (result <= 0) break;
    }
    socket.Close();
    
}
