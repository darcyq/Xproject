GamePlayMgr = Class("GamePlayMgr")

function GamePlayMgr:Init()

end

function GamePlayMgr:Update()

end

function GamePlayMgr:Destroy()
 
end

function GamePlayMgr:EnterScene()
    XLog(2)
    SceneMgr:LoadScene(1)
end

function GamePlayMgr:LeveaScene()
    SceneMgr:ReleaseScene()
end

Driver.Register(GamePlayMgr,Driver.Level.High)
