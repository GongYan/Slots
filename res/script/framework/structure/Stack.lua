--[[
    --Stack 
    @author xiaowa
    @date 2015.5.17
--]]
local Stack = Stack or class("Stack")
function Stack:ctor()
    self.stack_ = nil
    self.stack_end_ = nil --栈末尾的元素
    self.stack_num_ = 0 --栈元素数量
    self.PTR_NEXT = nil --保存下一个元素的指针
    self.CHECK = false --是否正在遍历表
end
--[[
    @function 压入栈顶一个元素
    @return Element#被压入的元素
--]]
function Stack:pushElement(value)
    assert(value ~= nil, string.format("%s:pushElement() - invalid value", self.class.__cname))
    self.stack_num_ = self.stack_num_ + 1
    local ptr = self.stack_
    if ptr then
        self.stack_end_.next = {}
        self.stack_end_.next.value = value
        self.stack_end_.next.prev = self.stack_end_ --双向表，这样pop就快
        self.stack_end_ = self.stack_end_.next
    else --栈没有初始化
        self.stack_ = {}
        self.stack_.value = value
        self.stack_end_ = self.stack_
    end
    --调整遍历指针代码
    if self.CHECK then
        if self.PTR_NEXT == nil then
            self.PTR_NEXT = self.stack_end_
        end
    end
    return value
end
--[[
    @function在栈的开头插入元素
    @return Element#被插入的元素
--]]
function Stack:insertFirstElement(value)
    assert(value ~= nil, string.format("%s:insertFirstElement() - invalid value", self.class.__cname))
    self.stack_num_ = self.stack_num_ + 1
    local ptr = self.stack_
    if ptr then
        self.stack_.prev = {}
        self.stack_.prev.value = value
        self.stack_.prev.next = self.stack_
        self.stack_ = self.stack_.prev
    else --栈没有初始化
        self.stack_ = {}
        self.stack_.value = value
        self.stack_end_ = self.stack_
    end
    return value
end
--[[
    @function 删除某个元素
    @return Element#被删除的元素
--]]
function Stack:delElement(value)
    assert(value ~= nil, string.format("%s:delElement() - invalid value", self.class.__cname))
    local ptr = self.stack_
    local ptr_prev
    while ptr do
        if ptr.value == value then
            --调整遍历指针代码
            if self.CHECK then
                if self.PTR_NEXT == ptr then
                    self.PTR_NEXT = self.PTR_NEXT.next
                end
            end
            self.stack_num_ = self.stack_num_ - 1   --数量减1
            if ptr_prev and ptr.next then --删除中间的元素
                ptr_prev.next = ptr.next
                ptr.next.prev = ptr_prev
                ptr.prev = nil
                ptr.next = nil
                break
            elseif ptr_prev == nil and ptr.next then --删除第一个元素
                self.stack_ = ptr.next
                ptr.next.prev = nil
                ptr.next = nil
                break
            elseif ptr_prev and ptr.next == nil then --删除末尾元素
                self.stack_end_ = ptr_prev
                ptr_prev.next = nil
                ptr.prev = nil
                break
            elseif ptr_prev == nil and ptr.next == nil then --删除唯一元素
                self.stack_ = nil
                self.stack_end_ = nil
                break
            else
                printLog("error","this is No way!")
            end
            return value
        end
        ptr_prev = ptr
        ptr = ptr.next
    end
end
--[[
    @function 弹出元素
    @return Element#value
--]]
function Stack:popElement()
    if self.stack_end_ == nil then
        return nil
    end
    --调整遍历指针代码
    if self.CHECK then
        if self.PTR_NEXT == self.stack_end_ then
            self.PTR_NEXT = self.PTR_NEXT.next
        end
    end
    self.stack_num_ = self.stack_num_ - 1   --数量减1
    local ptr_prev
    ptr_prev = self.stack_end_.prev
    if ptr_prev then
        ptr_prev.next = nil
        self.stack_end_.prev = nil
        local value = self.stack_end_.value
        self.stack_end_ = ptr_prev
        return value
    else --self.stack_end_ 是第一个元素，就是只有1个元素了
        self.stack_ = nil
        local value = self.stack_end_.value
        self.stack_end_ = nil
        return value
    end
end
--[[
    @function 弹出第一个元素
    @return Element#value
--]]
function Stack:removeFirstElement()
    if self.stack_ == nil then
        return nil
    end
    local ptr,ptr_next = self.stack_,self.stack_.next
    if ptr then
        --调整遍历指针代码
        if self.CHECK then
            if self.PTR_NEXT == ptr then
                self.PTR_NEXT = self.PTR_NEXT.next
            end
        end
        self.stack_num_ = self.stack_num_ - 1   --数量减1
        if ptr_next then
            ptr_next.prev = ptr.prev
            self.stack_ = ptr_next
            return ptr.value
        else
            self.stack_ = nil
            self.stack_end_ = nil --修复添加代码
            return ptr.value
        end
    end
    return nil
end
--[[
    @function 检查效果,检查函数中可以对栈进行操作
    @param function#检查函数，返回true 时停止检查
    @return nil
--]]
function Stack:checkElement(fun)
    assert(type(fun) == "function", string.format("%s:checkElement() - invalid value", self.class.__cname))
    self.CHECK = true
    local ptr = self.stack_
    while ptr do
        self.PTR_NEXT = ptr.next
        if fun(ptr.value) then
            break 
        end
        ptr = self.PTR_NEXT
    end
    self.CHECK = false
end
--[[
    @function 返回栈的长度
    @return number#栈的元素个数
--]]
function Stack:Len()
    return self.stack_num_
end
return Stack