extends Node

enum MONSTERS { NONE, SCORPION, BUG, SQUID, BLOB }
enum GAME_STATE { IDLE, AWAIT_INPUT, DOOR_TRANSITION }
enum PLAYER_STATE { IDLE, AIR, WALKING, ATTACK, HURT, GO_THROUGH_DOOR }
enum TAIL_TYPE { NONE, POOCH, WIZARD, ELF, THIEF, CLERIC, DWARF }
enum ROOMS {
	NONE,
	TEST_ROOM_1,
	PLAINS_START,
	PLAINS_VILLAGE_WEST,
	INN,
	GUILD,
	RESIDENT,
	PLAINS_WEST
}
enum ROOM_PARTICLE_EFFECTS {
	NONE,
	LEAVES
}

enum DIRECTIONS { RIGHT, UP, LEFT, DOWN }

var STORAGE_PATH = "user://data/data.json"
var HORI_SPEED = 130
var HORI_STOP = 0.4
var GRAVITY = 20
var JUMP_STRENGTH = -400

var SCREEN_SIZE_X = 352
var SCREEN_SIZE_Y = 256


var CURRENT_ROOM = ROOMS.PLAINS_START
var PREVIOUS_ROOM = ROOMS.NONE
var ROOM_X = 0
var ROOM_Y = 0

var TAIL_SIZE = 18
var X_POSITIONS = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var Y_POSITIONS = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
var TAIL_ANIMATION = [
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE,
	PLAYER_STATE.IDLE
]
var TAIL_DIRECTION = [
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false,
	false
]

var chargeCounter = 0.0
var playerState = PLAYER_STATE.IDLE
var gameState = GAME_STATE.IDLE
var mapOffestX = 0
var mapOffsetY = 0
var saveGameData = {
	"language": "en",
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
	},
	"tail1": {
		"type": TAIL_TYPE.THIEF
	},
	"tail2": {
		"type": TAIL_TYPE.WIZARD
	},
	"tail3": {
		"type": TAIL_TYPE.NONE
	},
}


