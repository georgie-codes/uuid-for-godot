class_name UUID extends Node
# This class uses Godots PCG32 RandomNumberGenerator.
# You can access this anywhere in your script by calling "UUID" 

# A very rudementary way of generating a 32 digit psuedo-random ID - Prefferred
static func Generate() -> String:
	var chars = "0123456789abcdef"
	var uuid = ""
	
	for i in range(36):
		if i == 8 or i == 13 or i == 18 or i == 23:
			uuid += "-"
		else:
			var rnd = randi() % 16
			uuid += chars[rnd]

	return uuid

# Based off of the UUIDv4 - Information was taken from Wikipedia.
static func UUIDv4() -> String:
	var uuid = ""
	for i in range(30):
		var rnd = randi() % 16
		uuid += "0123456789abcdef"[rnd]
	
	uuid = uuid.insert(12, "4")
	var variant_digit = 8 + (randi() % 4)
	uuid = uuid.insert(16, "0123456789abcdef"[variant_digit])
	
	uuid = "%s-%s-%s-%s-%s" % [uuid.substr(0,8), uuid.substr(8,4), uuid.substr(12, 4), uuid.substr(16, 4), uuid.substr(20)]
	
	return uuid

# Based off of "https://buildkite.com/blog/goodbye-integers-hello-uuids"
static func UUIDv7():
	var uuid = ""
	
	var timestamp = Time.get_unix_time_from_system()
	var ts_ms = int(timestamp * 1000) & ((1 << 48) - 1)
	var ts_hex = '%012x' % ts_ms
	
	var additional_bits = "7" + "0123456789abcdef"[randi() % 16]
	for i in range(17):
		additional_bits += "0123456789abcdef"[randi() % 16]
	
	additional_bits = additional_bits.insert(16, "8")
	
	uuid = "%s-%s-%s-%s-%s" % [ts_hex.substr(0, 8), ts_hex.substr(8, 4), additional_bits.substr(0, 4), additional_bits.substr(4, 4), additional_bits.substr(8)]
	
	return uuid
