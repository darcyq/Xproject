local space = "    "

local function ParseTable(tb,level,indent)
    local content = "{\n"
    local curIndent = indent..space
    for k, v in pairs(tb) do     
        local valueStr = ""
        local keyStr = ""
        if type(v) == "table" and level > 0 then
            valueStr = ParseTable(v,level-1,curIndent)
        else
            valueStr = tostring(v)
        end
        if type(k) ~= "string" then
            keyStr = "["..tostring(k).."]"
        else
            keyStr = tostring(k)
        end
        local totalStr = curIndent..keyStr.." = "..valueStr
        content = content .. totalStr .. "\n"
    end
    content = content..indent.."}"
    return content
end

local function Format(msg,...)
    local parms = {...}
    function search(k)
      return tostring(parms[k+1])
    end
    return (string.gsub(msg,"{(%d)}",search))
  end


local function ParseArgs(msg,...)
    if type(msg) == "table" then
        local args = table.pack(...)
        msg = ParseTable(msg,(args[1] or 3)-1,"")
        if args[2] then
            return tostring(args[2]).." = "..msg
        else
            return msg
        end
    else
        return Format(tostring(msg),...) 
    end
end

local function Log(msg,...)
    CS.UnityEngine.Debug.Log(ParseArgs(msg,...))
end

local function Warn(msg,...)
    CS.UnityEngine.Debug.LogWarning(ParseArgs(msg,...))
end

local function Error(msg,...)
    CS.UnityEngine.Debug.LogError(ParseArgs(msg,...))
end

XLog = Log
XWarn = Warn
XError = Error
