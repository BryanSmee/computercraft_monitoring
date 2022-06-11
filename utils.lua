function getLibName(peripheral_name)
    local block_name = peripheral_name:match('(.*)_')
    local lua_lib_path = "/libs/" .. string.gsub(block_name, ":", "/") .. "/api.lua"
    return lua_lib_path
end

function table.shallow_copy(t)
    local t2 = {}
    for k, v in pairs(t) do
        t2[k] = v
    end
    return t2
end

function dump(o)
    if type(o) == 'table' then
        local s = '{ '
        for k, v in pairs(o) do
            if type(k) ~= 'number' then k = '"' .. k .. '"' end
            s = s .. '[' .. k .. '] = ' .. dump(v) .. ','
        end
        return s .. '} '
    else
        return tostring(o)
    end
end

function getDataFromNetworkName(network_name, network_peripheral)
    local lib_name = getLibName(network_name)
    os.loadAPI(lib_name)
    local ok, err = pcall(function() raw_data = api.getData(network_name, network_peripheral) end)
    if err then
        print(err)
        return {}
    end
    local data = table.shallow_copy(raw_data)
    os.unloadAPI("api")
    return data

end
