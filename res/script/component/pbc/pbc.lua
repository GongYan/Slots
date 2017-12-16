require("script.component.pbc.protobuf")

protobuf.register_pb = function(filename)
    print("parse proto file:", filename)
    local fullname = cc.FileUtils:getInstance():fullPathForFilename(filename)
    local buffer = io.readfile(fullname)
    protobuf.register(buffer)
end

local proto_conf = {
    "proto/pbhead.pb",
    "proto/pblogin.pb",
}

protobuf.load_proto = function()
    for _,v in pairs(proto_conf) do
        protobuf.register_pb(v)
    end
end

protobuf.load_proto()