import redis

redis_client = redis.StrictRedis(host='localhost', port=6379, db=0)
key_schema = 'sample:key:schema'
print(redis_client)
keys = redis_client.keys('*')
for key in keys:
    type = redis_client.type(key)
    if type == "list":
        vals = redis_client.lrange(key, 0, 1)
        print(vals)
        
    
print(keys)