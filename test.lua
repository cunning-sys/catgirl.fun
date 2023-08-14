local stored;
local startup_args = ({...})[1] or nil

if startup_args then
  stored = startup_args[1]
end
