function getData(network_name, network_peripheral, slot_number)
    item_details = network_peripheral.callRemote(network_name, "getItemDetail", slot_number)
    if item_details == nil then
        return nil
    end
    return { measure = { count = item_details.count },
        tags = { item_name = item_details.name, display_name = item_details.displayName, max = -1 } }
end

fallback_value = { measure = { count = 0 },
    tags = { item_name = "minecraft:air", display_name = "None", max = -1 } }