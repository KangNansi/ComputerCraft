os.loadAPI("json")

local gaddr = "https://api.github.com/"

local args = {...}

if args[1] == "get" then
    local repo = args[2]

    local r = http.get(gaddr..repos/KangNansi/..repo../contents/)

    local obj = json.decode(r.readAll())

    for i, v in pairs(obj) do 
        print(i..": "..v)
        os.pullEvent()
    end
end
