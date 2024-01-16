CameraMgr = Class("CameraMgr")

function CameraMgr:Init()
    -- self.mainCamera = CSGameObject.Find("MainCamera")
    -- self.followCmp = CSGoTool.GetComponent(self.mainCamera,"FollowTargetCmp")
end

-- function CameraMgr:FollowTarget(target,offset)
--     self.followCmp.target = target
--     self.followCmp.offset = offset
-- end

function CameraMgr:Update()

end

function CameraMgr:Destroy()
    
end

Driver.Register(CameraMgr)
