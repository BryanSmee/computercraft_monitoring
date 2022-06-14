function Set(list)
    local set = {}
    for _, l in ipairs(list) do set[l] = true end
    return set
end

function getData(network_name, network_peripheral)
    settings.load("/ae2.settings")
    local ae2_config = settings.get("ae2")
    local watch_list = Set(ae2_config.watch_list)

    local item_list = network_peripheral.callRemote(network_name, "listItems")

    local return_data = {}

    for _, item in pairs(item_list) do
        if watch_list[item.name] then
            new_data = { measure = { count = item.amount },
                tags = { item_name = item.name, display_name = item.displayName, max = -1 } }
            return_data[#return_data + 1] = new_data
        end
    end

    return return_data
end
