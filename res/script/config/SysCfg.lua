local SysCfg = {}

SysCfg.winSize =cc.Director:getInstance():getWinSize()
SysCfg.winCenter = cc.p(SysCfg.winSize.width * 0.5, SysCfg.winSize.height * 0.5)

return SysCfg