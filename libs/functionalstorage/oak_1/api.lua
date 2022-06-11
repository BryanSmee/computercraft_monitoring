function getData(network_name, network_peripheral)
    os.loadAPI("/libs/functionalstorage/common.lua")
    data = common.getData(network_name, network_peripheral, 1)
    if data == nil then return common.fallback_value end
    os.unloadAPI("common")
    return data
end
