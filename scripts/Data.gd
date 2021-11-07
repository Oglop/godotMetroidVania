extends Node

var map = []

var rooms = {
	"testRoom1": {
		"title": "Welcome to my shop",
		"monsters": {
			"normal": Global.MONSTERS.BUG,
			"rare": Global.MONSTERS.SCORPION,
			"big": Global.MONSTERS.SQUID
		}
	}
}

var monsters = {
	"bug": {
		"title": "Bug",
		"hp": 12,
		"speed": 50,
		"defence": 2
	}
}

var data = {
	"lv":1,
	"hp":0,
	"mp":0,
	"room": {
		"current": Global.ROOMS.NONE,
		"x":0,
		"y":0
	},
	"tail1": {
		"type": Global.TAIL_TYPE.DWARF
	},
	"tail2": {
		"type": Global.TAIL_TYPE.NONE
	},
	"tail3": {
		"type": Global.TAIL_TYPE.NONE
	},
	"inventory": {
		"lockPicks": {
			"found": false
		},
		"bomb": {
			"found": true
		},
		"spellBook": {
			"found": false,
			"level": 1
		}
	},
	"weapon": {
		"tier1": {
			"found": true,
			"equiped": true
		},
		"tier2": {
			"found": false,
			"equiped": false
		},
		"tier3": {
			"found": false,
			"equiped": false
		}
	}, 
	"armor": {
		"tier1": {
			"found": true,
			"equiped": true
		},
		"tier2": {
			"found": false,
			"equiped": false
		},
		"tier3": {
			"found": false,
			"equiped": false
		}
	},
	"shield": {
		"tier1": {
			"found": true,
			"equiped": true
		},
		"tier2": {
			"found": false,
			"equiped": false
		},
		"tier3": {
			"found": false,
			"equiped": false
		}
	}
}

