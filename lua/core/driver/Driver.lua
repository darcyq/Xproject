Driver = {}
Driver.Level = {High = 1,Mid = 2,Low = 3,}
Driver.handles = {}
Driver.registers = {}
for key, level in pairs(Driver.Level) do
    Driver.handles[level] = {}
end

function Driver.Register(mgr,level)
    --避免重复注册
    if not Driver.registers[mgr] then
        level = level or Driver.Level.Mid
        table.insert(Driver.handles[level],mgr)
        if mgr.Init then
            mgr:Init()
        end
        Driver.registers[mgr] = true
    end
end

function Driver.Update(detlaTime)
    for level, mgrs in ipairs(Driver.handles) do
        for _, mgr in ipairs(mgrs) do
            if(mgr.Update) then
                mgr:Update(detlaTime)               
            end
        end
    end
end

function Driver.FixedUpdate(detlaTime)
    for level, mgrs in ipairs(Driver.handles) do
        for _, mgr in ipairs(mgrs) do
            if(mgr.FixedUpdate) then
                mgr:FixedUpdate(detlaTime)               
            end
        end
    end
end

function Driver.Destroy()
    for level, mgrs in ipairs(Driver.handles) do
        for _, mgr in ipairs(mgrs) do
            if(mgr.Destroy) then
                mgr:Destroy()               
            end
        end
    end
end