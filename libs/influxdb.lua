config = {
    server_url = "",
    org = "",
    bucket_name = "",
    org_token = "",
    api_full_url = "",
    headers = {}
}

function init(_server_url, _org, _bucket_name, _org_token)
    config.server_url = _server_url
    config.org = _org
    config.bucket_name = _bucket_name
    config.org_token = _org_token

    config.headers = { Authorization = "Token " .. _org_token }
    config.api_full_url = _server_url .. "/api/v2/write?org=" .. _org .. "&bucket=" .. _bucket_name
end

function generate_influx_string(measurement, tags, data)
    local temp = measurement
    for tag, value in pairs(tags) do
        temp = temp .. "," .. tag .. "=" .. tostring(value):gsub(" ", "\\ ")
    end
    temp = temp .. " "
    data_str = ""
    for key, value in pairs(data) do
        data_str = data_str .. "," .. key .. "=" .. value
    end
    return temp .. data_str:sub(2)
end

function write_raw(data_string)
    a, b, c = http.post(config.api_full_url, data_string, config.headers)
    if a == nil then
        print(c.readAll())
    end
end

function write(measurement, tags, data)
    output_string = generate_influx_string(measurement, tags, data)
    return write_raw(output_string)
end
