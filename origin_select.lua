local redis = require "resty.redis"
local json = require "cjson"
local red = redis:new()

local host = ngx.var.http_host
local request_uri = ngx.var.request_uri
local uri = ngx.var.uri
local is_desktop = ngx.var.is_desktop

local cache_key = host .. request_uri

red:connect("127.0.0.1", 6380)
red:select(0)
local res, err = red:get(host)
ngx.var.x_upstream_addr = res
ngx.var.x_host = res

red:select(1)
local res, err = tonumber(red:get(host))
if res == 0 then
    cache_key = host .. uri
elseif res == 1 then
    cache_key = host .. request_uri
elseif res == 2 then
    cache_key = is_desktop .. host .. uri
elseif res == 3 then
    cache_key = is_desktop .. host .. request_uri
end

-- red:select(2)
-- local cookie_cache_keys = json.decode(red:get(host))
-- local cookie_key = ""
-- if get_cookies ~= nil then
--     if cookie_cache_keys ~= nil then
--         for key, cookie_value_list in pairs(cookie_cache_keys) do 
--             local cookie_value = get_cookies[key] or ""
--             for i, value in ipairs(cookie_value_list) do
--                 if value == cookie_value then
--                     cookie_key = cookie_key .. cookie_value
--                 end
--             end
--         end
--     end
-- end

ngx.var.x_cache_key = cache_key
ngx.log(ngx.ERR, ngx.var.x_cache_key)
