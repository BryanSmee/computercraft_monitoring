shell.run("rm /configure.lua /startup.lua /utils.lua /libs")

local current_dir = fs.getDir(shell.getRunningProgram())
shell.run("cp /" .. current_dir .. "/* /")
shell.run("/configure")
shell.run("rm /install.lua")
os.reboot()
