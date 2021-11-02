extends Node

var map = []

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
		"type": Global.TAIL_TYPE.POOCH
	},
	"tail2": {
		"type": Global.TAIL_TYPE.THIEF
	},
	"tail3": {
		"type": Global.TAIL_TYPE.NONE
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

