local redis = require "resty.redis"
local json = require "cjson"
local red = redis:new()

local cache_key = ""
host = ngx.var.host
request_uri = ngx.var.request_uri
uri = ngx.var.uri
is_desktop = ngx.var.is_desktop

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

ngx.log(ngx.ERR, "Cache key is: " .. tostring(ngx.var.x_cache_key))
ngx.log(ngx.ERR, "Is desktop status is: " .. tostring(ngx.var.is_desktop))