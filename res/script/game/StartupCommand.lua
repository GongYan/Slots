
local StartupCommand = class("StartupCommand", FILE.MacroCommand)

function StartupCommand:initializeMacroCommand()
	self:addSubCommand(FILE.BootstrapController)
	self:addSubCommand(FILE.BootstrapModel)
	self:addSubCommand(FILE.BootstrapView)
end


return StartupCommand