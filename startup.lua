os.loadAPI("/disk/utils.lua")
os.loadAPI("/disk/libs/influxdb.lua")

local network_per = peripheral.wrap(settings.get("network_side"))
local i = 0

influxdb_config = settings.get("influxdb")

influxdb.init(influxdb_config.server_url, influxdb_config.org, influxdb_config.bucket, influxdb_config.token)


while true do
    if i % settings.get("network_refresh_rate") == 0 then
        block_names = network_per.getNamesRemote()
    end

    update_string = ""
    measurement_count = 0
    for i, name in ipairs(block_names) do
        local data = utils.getDataFromNetworkName(name, network_per)
        update_string = update_string .. influxdb.generate_influx_string("itemCount", data.tags, data.measure) .. "\n"
        measurement_count = measurement_count + 1
    end

    print(measurement_count .. " measures done")
    if measurement_count > 0 then
        influxdb.write_raw(update_string)
    end


    i = i + 1
    if i > 1000000000 then
        i = 0
    end

    os.sleep(1 / settings.get("sample_rate"))
    term.clear()
    term.setCursorPos(1, 1)
end
