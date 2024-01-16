InputMgr = Class("InputMgr")

function InputMgr:Init()
    
end

function InputMgr:Update()
    -- if CSInput.GetKeyDown('u') then
    --     self.taskIndex = LoadMgr:CreateTask("Prefab_UILoading",function (obj)
    --         XLog("success")
    --         XLog(obj)
    --     end,function ()
    --         XLog("fail")
    --     end)
    --     LoadMgr:LoadTask(self.taskIndex)
    -- end
    if CSInput.GetKeyDown('p') then
        -- XLog(CS.)
    end
    
    if CSInput.GetKeyDown('i') then
        GamePlayMgr:LeveaScene()
    end

    if CSInput.GetKeyDown('o') then
        XLog(1111)
        GamePlayMgr:EnterScene()
    end
end

function InputMgr:Destroy()
 
end

Driver.Register(InputMgr,Driver.Level.Low)