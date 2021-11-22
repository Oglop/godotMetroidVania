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
		"defence": 2,
		"xp": 10
	},
	"scorpion": {
		"title": "Scorpion",
		"hp": 14,
		"speed": 150,
		"defence": 1,
		"xp": 10
	}
}

var tailData = {
	"weapons": {
		"dwarfAxe": {
			"duration": 0.2,
			"damage": 3,
			"speed": 340
		},
		"thiefKnife": {
			"duration": 0.2,
			"damage": 2,
			"speed": 340
		},
		"wizardFireball": {
			"duration": 0.4,
			"damage": 5,
			"speed": 220
		},
		"swordAttackTier1": {
			"duration": 0.2,
			"damage": 3,
			"speed": 340
		},
		"swordAttackTier2": {
			"duration": 0.3,
			"damage": 3,
			"speed": 340
		},
		"swordAttackTier3": {
			"duration": 0.4,
			"damage": 3,
			"speed": 340
		}
	}
}

var data = {
	"lastSave": "",
	"language":"en",
	"lv":1,
	"currentHP":0,
	"maxHP": 100,
	"currentMP":0,
	"maxMP":100,
	"room": {
		"current": Global.ROOMS.NONE,
		"x":0,
		"y":0
	},
	"tail1": {
		"type": Global.TAIL_TYPE.NONE
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

