
DE_CONFIG_DIR = "./config"
CONFIG_DIR = "/home/$USER/.config"

print("Personal rice - desktop environment")

-- install dependencies
dependencies_list = { "awesome", "konsole", "cbatticon" }
os.execute("sudo apt -y install " ..
	table.concat(dependencies_list," ")
)

-- copy configurations
print( "copying awesomeWM confi files" )
os.execute("cp " .. DE_CONFIG_DIR .. "/awesome/* " .. CONFIG_DIR .. "/awesome")
