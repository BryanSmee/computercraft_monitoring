print("Network modem side:")
network_side = read()
settings.set("network_side", network_side)

print("Network refresh rate (recommanded: 10):")
network_refresh_rate = read()
settings.set("network_refresh_rate", network_refresh_rate)

print("Sample rate (recommanded: 0.2):")
sample_rate = read()
settings.set("sample_rate", sample_rate)

print("influxdb server url")
server_url = read()

print("influxdb org")
org = read()

print("influxdb bucket")
bucket = read()
print("influxdb token")
token = read()


influxdb = {
    server_url = server_url,
    org = org,
    bucket = bucket,
    token = token
}

settings.set("influxdb", influxdb)

settings.save(".settings")

ae2_config = { watch_list = {} }

settings.clear()
settings.set("ae2", ae2_config)
settings.save("/ae2.settings")
