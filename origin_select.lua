local redis = require "resty.redis"
local json = require "cjson"
local red = redis:new()

host = ngx.var.host

red:connect("127.0.0.1", 6380)
red:select(0)
local res, err = red:get(host)
ngx.var.x_upstream_addr = res
ngx.var.x_host = res
ngx.log(ngx.ERR, ngx.var.x_upstream_addr)