
local function createS(inst)
    local SBase = {}
    setmetatable(SBase,{
        __index = function(table,key)
            local func = function(...)
                inst[key](inst,...)
            end
            table[key] = func
            return func
        end
    })
    return SBase
end

local function Ctor(cls,inst,...)
    if cls.__super then
        Ctor(cls.__super,inst,...)
    end
    if cls.Ctor then
        cls.Ctor(inst,...)
    end
end

ClassTable = ClassTable or {}
function Class(className, super)
    if not ClassTable[className] then
        local class = {}
        class.__cname = className
        class.__super = super
        class.S_ = createS(class)
        setmetatable(class,{__index = super})
    
        class.New = function(...)
            local inst = {}
            inst.S_ = createS(inst)
            setmetatable(inst,{__index = class})
            Ctor(class,inst,...)
            return inst
        end
        ClassTable[className] = class
    end
    return ClassTable[className]
end

--只热更函数
function HotFix(moduleList)
    for i = 0, moduleList.Count-1, 1 do
        XLog("hotfix:"..moduleList[i])
        package.loaded[moduleList[i]] = nil
        require(moduleList[i])
    end
end

-- function InstanceClass(className,super)
--     local Class(className, super)
-- end