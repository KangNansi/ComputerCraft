os.loadAPI("json")

local gaddr = "https://api.github.com/"

local args = {...}

function GetFileName(s)
    return string.sub(s, 0, string.len(s) - 4)
end

local dir = "/lzos"
local r = http.get(gaddr.."repos/KangNansi/ComputerCraft/contents/")
local s = r.readAll()

local obj = json.decode(s)

for _, file in pairs(obj) do 
    print("download..."..file.name)

    local filename = ""

    if file.name == "startup" then
        filename = file.name
    else
        filename = dir.."/"..GetFileName(file.name)
    end
        
    if not fs.isDir(dir) then
        fs.makeDir(dir)
    end
    if fs.exists(filename) then
        fs.delete(filename)
    end
    
    local fileContent = http.get(file.download_url)
    local fh = fs.open(filename, "w")
    fh.write(fileContent.readAll())
    fh.close()
end
