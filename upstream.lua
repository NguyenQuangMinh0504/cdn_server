local redis = require "resty.redis"
local json = require "cjson"
local red = redis:new()

host = ngx.var.host

red:connect("127.0.0.1", 6380)
red:select(1)
ngx.log(ngx.ERR, "Host is " .. host)
local res, err = red:get(host)
ngx.log(ngx.ERR, "Res is " .. res)
local config = json.decode(res)
ngx.var.x_upstream_addr = config["ip"]
ngx.var.x_host = config["host"]
local h = ngx.req.get_headers()
  for k, v in pairs(h) do
    ngx.log(ngx.ERR, "Got header "..k..": "..tostring(v)..";")
  end
ngx.log(ngx.ERR, ngx.var.x_upstream_addr)
