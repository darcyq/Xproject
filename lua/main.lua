
local function Init()
    require("lua.core.CoreInclude")
    require("lua.gameplay.GameplayInclude")
end

local function Update(deltaTime)
    Driver.Update(deltaTime)
end
local function FixedUpdate(deltaTime)
    Driver.FixedUpdate(deltaTime)
end
local function Destroy()
    Driver.Destroy()
end
Init()
CS.LuaManager.Instance.updateFunc = Update
CS.LuaManager.Instance.fixedUpdateFunc = FixedUpdate
CS.LuaManager.Instance.destroyFunc = Destroy