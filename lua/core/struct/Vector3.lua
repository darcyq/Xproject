Vector3 = Vector3 or {}

Vector3.New = function(x,y,z)
    local inst = {}
    inst.x = x
    inst.y = y
    inst.z = z
    setmetatable(inst,Vector3)
    return inst
end
