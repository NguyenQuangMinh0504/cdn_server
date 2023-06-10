local redis = require "resty.redis"
local json = require "cjson"
local red = redis:new()

host = ngx.var.host
request_uri = ngx.var.request_uri
uri = ngx.var.uri

red:connect("127.0.0.1", 6380)
red:select(0)
local res, err = red:get(host)
ngx.var.x_upstream_addr = res
ngx.var.x_host = res
red:select(1)
local res, err = tonumber(red:get(host))
if res == 1 then
    ngx.var.x_cache_key = host .. request_uri
elseif res == 0 then
    ngx.var.x_cache_key = host .. uri
end

ngx.log(ngx.ERR, "Cache key is: " .. tostring(ngx.var.x_cache_key))
ngx.log(ngx.ERR, "Is desktop status is: " .. tostring(ngx.var.is_desktop))