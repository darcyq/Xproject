LoadMgr = Class("LoadMgr")

LoadMgr.AssetTypes = {
    Instance = 1,
}

function LoadMgr:Init()
    self.index = 0
    self.taskMap = {}

    self.loader = CS.LoadManager.Instance
    self.loader.failCb = self.S_.LoadFailed
    self.loader.successCb = self.S_.LoadSuccess
end

function LoadMgr:CreateTask(location,successCb,failedCb, assetType)
    local index = self.index
    local task = {
        location = location,
        successCb = successCb,
        failedCb = failedCb,
        assetType = assetType or LoadMgr.AssetTypes.Instance,    
        index = index,
    }
    self.taskMap[index] = task
    self.index = index + 1
    return index
end

function LoadMgr:LoadTask(index)
    if self.taskMap[index] then
        local task = self.taskMap[index]
        self.loader:LoadAsset(task.index, task.location,task.assetType)
    else
        XError("没有对应的任务!!"..tostring(index))
    end
end

function LoadMgr:ReleaseTask(index)
    if index then
        self.taskMap[index] = nil
        self.loader:ReleaseAsset(index)
    end
end

function LoadMgr:LoadSuccess(index,obj)
    local task = self.taskMap[index]
    if task and task.successCb then
        task.successCb(obj)
    end
end

function LoadMgr:LoadFailed(index)
    local task = self.taskMap[index]
    if task and task.failedCb then
        task.failedCb()
    end
end

function LoadMgr:GC()
    self.loader:GC()
end

-- function LoadMgr:Update()
--     -- XLog("LoadMgr:Update")
-- end

-- function LoadMgr:FixedUpdate()
--     -- XLog("LoadMgr:FixedUpdate")
-- end

-- function LoadMgr:Destroy()
--     -- XLog("LoadMgr:Destroy")
-- end

Driver.Register(LoadMgr,Driver.Level.Mid)