local t = {}

t.__index = t

function table.contains(t, elem)
    if type(t) ~= "table" then return end
    
    for _, v in pairs(t) do
        if v == elem then
          return true
        end
    end

    return false
end

function showTable(t, n)
    if type(t) ~= "table" then return end
    if not n then
        print("\nContent of table")
        n = 0
    end

    for k, v in pairs(t) do
        for i = 1, n do io.write("\t") end
        print("'-> ", k, v)
        --showTable(v, n + 1) 
    end
end

function table.getKey(t, value)
    for k, v in pairs(t) do
        if v == value then return k end
    end
end

return t