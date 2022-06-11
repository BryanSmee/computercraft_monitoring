function getData(network_name, network_peripheral)
    os.loadAPI("/libs/functionalstorage/common.lua")
    for i = 1, 3 do
        data = common.getData(network_name, network_peripheral, i)
        if data ~= nil then
            break
        end
    end
    if data == nil then return common.fallback_value end
    os.unloadAPI("common")
    return data
end
