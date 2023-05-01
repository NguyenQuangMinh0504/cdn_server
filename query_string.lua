local cache_query_string = 0
local query_string_cache_status = 0

if cache_query_string == 1 then
    query_string_cache_status = 1
elseif cache_query_string == 0 then
    query_string_cache_status = 0
else
    query_string_cache_status = 1
end

if string.find(ngx.var.args, "facebook_campaign") then
    query_string_cache_status = 0
end

local args = ngx.req.get_uri_args()
ngx.log(ngx.INFO, args)
for key, val in pairs(args) do
    ngx.log(ngx.INFO, "Key and value is" .. key .. val)
ngx.log(ngx.INFO, "dafuq")


if string.find(ngx.var.args, "id") then
    query_string_cache_status = 1
end

ngx.var.query_string_cache_status = query_string_cache_status
