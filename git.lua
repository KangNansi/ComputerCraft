os.loadAPI("json")

local gaddr = "https://api.github.com/"

local args = {...}

function GetFileName(s)
    return string.sub(s, 0, string.len(s) - 4)
end

if args[1] == "get" then
    local dir = "lzos"
    local r = http.get(gaddr.."repos/KangNansi/ComputerCraft/contents/")
    local s = r.readAll()

    local obj = json.decode(s)

    for _, file in pairs(obj) do 
        print("download..."..file.name)

        local filename = dir.."/"..GetFileName(file.name)
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
end
