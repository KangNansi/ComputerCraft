os.loadAPI("json.lua")

local gaddr = "https://api.github.com/"

local args = {...}

function GetFileName(s)
    return string.sub(s, 0, string.len(s) - 4)
end

local dir = "/lzos"

local dirs = {}
local dirCount = 0

function pushDir(dirName)
    dirs[dirCount] = dirName
    dirCount = dirCount + 1
end

function popDir()
    dirCount = dirCount - 1
    if dirCount < 0 then 
        dirCount = 0 
    end
end

function getDir()
    local r = dir
    for i = 0, dirCount-1 do
        r = r.."/"..dirs[i]
    end
    return r
end

function downloadFile(file)
    print("Downloading "..file.name.."...")
    local dirPath = getDir()
    fs.makeDir(dirPath)
    local filePath = dirPath.."/"..GetFileName(file.name)
    local fileContent = http.get(file.download_url)
    local file = fs.open(filePath, "w")
    file.write(fileContent.readAll())
    file.close()
end

function downloadGit(target)
    local addr = gaddr.."repos/KangNansi/ComputerCraft/contents"
    if target then
        addr = addr.."/"..target
    end
    target = target or ""
    local content = http.get(addr)
    local obj = json.decode(content.readAll())
    for _, file in pairs(obj) do
        if file.type == "file" then
            downloadFile(file)
        elseif file.type == "dir" then
            pushDir(file.name)
            downloadGit(target.."/"..file.name)
            popDir()
        end
    end
end

downloadGit()

