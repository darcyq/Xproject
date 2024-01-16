-- require ("lua.gameplay.level.Level")
SceneMgr = Class("SceneMgr")

function SceneMgr:Init()

end
--加载关卡
function SceneMgr:LoadScene(sceneId)
    self.config = {
        sceneId = sceneId,
        location = "scene_background1",
    }
    self.taskIndex = LoadMgr:CreateTask(self.config.location,self.S_.LoadSuccess,self.S_.LoadFailed)
    LoadMgr:LoadTask(self.taskIndex)
end

function SceneMgr:LoadSuccess(obj)
    self.sceneObj = obj
    XLog("load scene success:{0}",self.config.sceneId)
end

function SceneMgr:LoadFailed()
    XLog("load scene failed:{0}",self.config.sceneId)
end

function SceneMgr:ReleaseScene()
    LoadMgr:ReleaseTask(self.taskIndex)
    if IsNotNull(self.sceneObj) then
        CSGameObject.DestroyImmediate(self.sceneObj)
        self.sceneObj = nil
    end
end

function SceneMgr:Update()

end

function SceneMgr:Destroy()
    
end

Driver.Register(SceneMgr)
