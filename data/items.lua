return {
	['testburger'] = {
		label = 'Test Burger',
		weight = 220,
		degrade = 60,
		client = {
			image = 'burger_chicken.png',
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			export = 'ox_inventory_examples.testburger'
		},
		server = {
			export = 'ox_inventory_examples.testburger',
			test = 'what an amazingly delicious burger, amirite?'
		},
		buttons = {
			{
				label = 'Lick it',
				action = function(slot)
					print('You licked the burger')
				end
			},
			{
				label = 'Squeeze it',
				action = function(slot)
					print('You squeezed the burger :(')
				end
			},
			{
				label = 'What do you call a vegan burger?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('A misteak.')
				end
			},
			{
				label = 'What do frogs like to eat with their hamburgers?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('French flies.')
				end
			},
			{
				label = 'Why were the burger and fries running?',
				group = 'Hamburger Puns',
				action = function(slot)
					print('Because they\'re fast food.')
				end
			}
		},
		consume = 0.3
	},

	['bandage'] = {
		label = 'Bandage',
		weight = 115,
		client = {
			anim = { dict = 'missheistdockssetup1clipboard@idle_a', clip = 'idle_a', flag = 49 },
			prop = { model = `prop_rolled_sock_02`, pos = vec3(-0.14, -0.14, -0.08), rot = vec3(-50.0, -50.0, 0.0) },
			disable = { move = true, car = true, combat = true },
			usetime = 2500,
		}
	},

	['black_money'] = {
		label = 'Dirty Money',
	},

	['burger'] = {
		label = 'Burger',
		rarity = 'uncommon',
		weight = 220,
		client = {
			status = { hunger = 200000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious burger'
		},
		prop = `prop_cs_burger_01`
	},

	['sprunk'] = {
		label = 'Sprunk',
		weight = 350,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_can_01`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with a sprunk'
		}
	},

	['parachute'] = {
		label = 'Parachute',
		weight = 8000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 1500
		}
	},

	['garbage'] = {
		label = 'Garbage',
	},

	['paperbag'] = {
		label = 'Paper Bag',
		weight = 1,
		stack = false,
		close = false,
		consume = 0
	},

	['identification'] = {
		label = 'Identification',
		client = {
			image = 'card_id.png'
		}
	},

	['panties'] = {
		label = 'Knickers',
		weight = 10,
		consume = 0,
		client = {
			status = { thirst = -100000, stress = -25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_cs_panties_02`, pos = vec3(0.03, 0.0, 0.02), rot = vec3(0.0, -13.5, -1.5) },
			usetime = 2500,
		}
	},

	['lockpick'] = {
		label = 'Lockpick',
		weight = 160,
		rarity = 'rare'
	},

	['phone'] = {
		label = 'Phone',
		weight = 190,
		stack = false,
		consume = 0,
		client = {
			add = function(total)
				if total > 0 then
					pcall(function() return exports.npwd:setPhoneDisabled(false) end)
				end
			end,

			remove = function(total)
				if total < 1 then
					pcall(function() return exports.npwd:setPhoneDisabled(true) end)
				end
			end
		}
	},
	["yphone"] = {
    label = "YPhone",
    weight = 100,
    stack = false,
    consume = 0,
    client = {
        export = "yseries.UsePhoneItem",
        remove = function()
            TriggerEvent("yseries:phone-item-removed")
        end,
        add = function()
            TriggerEvent("yseries:phone-item-added")
        end,
		image = 'V2_yphone_black.png'
    }
	},
	["yphone_natural"] = {
		label = "YPhone Natural",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_yphone_natural.png'
		}
	},
	["yphone_black"] = {
		label = "YPhone Black",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_yphone_black.png'
		}
	},
	["yphone_white"] = {
		label = "YPhone White",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_yphone_white.png'
		}
	},
	["yphone_blue"] = {
		label = "Phone",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_yphone_blue.png'
		}
	},
	["yflipphone"] = {
		label = "Phone",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_yflip_graphite.png'
		}
	},
	["yflip_mint"] = {
		label = "YFlip Mint",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_yflip_mint.png'
		}
	},
	["yflip_gold"] = {
		label = "YFlip Gold",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_yflip_gold.png'
		}
	},
	["yflip_graphite"] = {
		label = "YFlip Graphite",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_yflip_graphite.png'
		}
	},
	["yflip_lavender"] = {
		label = "YFlip Lavender",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_yflip_lavender.png'
		}
	},
	["y24_black"] = {
		label = "Y24 Black",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_y24_black.png'
		}
	},
	["y24_silver"] = {
		label = "Y24 Silver",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_y24_silver.png'
		}
	},
	["y24_violet"] = {
		label = "Y24 Violet",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_y24_violet.png'
		}
	},
	["y24_yellow"] = {
		label = "Y24 Yellow",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_y24_yellow.png'
		}
	},
	["yfold_black"] = {
		label = "YFold Black",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end,
			image = 'V2_yfold_black.png'
		}
	},
	["yphone_fold_black"] = {
		label = "YPhone Fold Black",
		weight = 100,
		stack = false,
		consume = 0,
		client = {
			export = "yseries.UsePhoneItem",
			remove = function()
				TriggerEvent("yseries:phone-item-removed")
			end,
			add = function()
				TriggerEvent("yseries:phone-item-added")
			end
		}
	},
	['ys_sim_card'] = {
		label = 'Sim Card',
		stack = false,
		weight = 10,
		consume = 0,
	},
	['usb_cable'] = {
		label = 'USB Type-C',
		weight = 50,
		stack = true,
		close = true,
		description = 'USB cable for charging.',
		client = {
			image = 'usb_cable.png',
			export = "yseries.UseUSBCable"
		}
	},

	['money'] = {
		label = 'Money',
		prop = `prop_anim_cash_pile_02`,
	},

	['water'] = {
		label = 'Water',
		weight = 500,
		client = {
			status = { thirst = 200000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ld_flow_bottle`, pos = vec3(0.03, 0.03, 0.02), rot = vec3(0.0, 0.0, -1.5) },
			usetime = 2500,
			cancel = true,
			notification = 'You drank some refreshing water'
		},
		prop = `prop_ld_flow_bottle`
	},

	['radio'] = {
		label = 'Radio',
		weight = 1000,
		stack = false,
		allowArmed = true
	},
	
	['armour'] = {
		label = 'Bulletproof Vest',
		weight = 3000,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500
		}
	},

	['clothing'] = {
		label = 'Clothing',
		consume = 0,
	},

	['mastercard'] = {
		label = 'Fleeca Card',
		stack = false,
		weight = 10,
		client = {
			image = 'card_bank.png'
		}
	},

	['scrapmetal'] = {
		label = 'Scrap Metal',
		weight = 80,
	},

	-- Can't call it armour because of vest system, items with 'armour' in name is considered as vest item...
	['armor_plate'] = {
		label = 'Armour Plate',
		weight = 250,
		stack = false,
		client = {
			anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
			usetime = 3500,
			image = 'armour_plate.png'
		}
	},

		["weed_skunk"] = {
		label = "Skunk 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g Skunk",
		client = {
			image = "weed_baggy.png",
		}
	},

	["police_stormram"] = {
		label = "Stormram",
		weight = 18000,
		stack = true,
		close = true,
		description = "A nice tool to break into doors",
		client = {
			image = "police_stormram.png",
		}
	},

	["harness"] = {
		label = "Race Harness",
		weight = 1000,
		stack = false,
		close = true,
		description = "Racing Harness so no matter what you stay in the car",
		client = {
			image = "harness.png",
		}
	},
	["fakeplate"] = {
		label = "Fakeplate",
		weight = 0,
		stack = false,
		close = true,
		description = "fakeplate",
		client = {
			image = "fakeplate.png",
		}
	},

	["moneybag"] = {
		label = "Money Bag",
		weight = 0,
		stack = false,
		close = true,
		description = "A bag with cash",
		client = {
			image = "moneybag.png",
		}
	},

	["diving_gear"] = {
		label = "Diving Gear",
		weight = 30000,
		stack = false,
		close = true,
		description = "An oxygen tank and a rebreather",
		client = {
			image = "diving_gear.png",
		}
	},

	["iphone"] = {
		label = "iPhone",
		weight = 1000,
		stack = true,
		close = true,
		description = "Very expensive phone",
		client = {
			image = "iphone.png",
		}
	},

	["trojan_usb"] = {
		label = "Trojan USB",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to shut down some systems",
		client = {
			image = "usb_device.png",
		}
	},

	["flipper"] = {
		label = "Flipper Remix",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy Tool for those Hacking Needs",
		client = {
			image = "flipper.png",
		}
	},

	["visa"] = {
		label = "Visa Card",
		weight = 0,
		stack = false,
		close = false,
		description = "Visa can be used via ATM",
		client = {
			image = "visacard.png",
		}
	},

	["dendrogyra_coral"] = {
		label = "Dendrogyra",
		weight = 1000,
		stack = true,
		close = true,
		description = "Its also known as pillar coral",
		client = {
			image = "dendrogyra_coral.png",
		}
	},

	["samsungphone"] = {
		label = "Samsung S10",
		weight = 1000,
		stack = true,
		close = true,
		description = "Very expensive phone",
		client = {
			image = "samsungphone.png",
		}
	},

	["empty_weed_bag"] = {
		label = "Empty Weed Bag",
		weight = 0,
		stack = true,
		close = true,
		description = "A small empty bag",
		client = {
			image = "weed_baggy_empty.png",
		}
	},

	["casinochips"] = {
		label = "Casino Chips",
		weight = 0,
		stack = true,
		close = false,
		description = "Chips For Casino Gambling",
		client = {
			image = "casinochips.png",
		}
	},

	["stickynote"] = {
		label = "Sticky note",
		weight = 0,
		stack = false,
		close = false,
		description = "Sometimes handy to remember something :)",
		client = {
			image = "stickynote.png",
		}
	},

	["weed_white-widow_seed"] = {
		label = "White Widow Seed",
		weight = 0,
		stack = true,
		close = false,
		description = "A weed seed of White Widow",
		client = {
			image = "weed_seed.png",
		}
	},

	["lawyerpass"] = {
		label = "Lawyer Pass",
		weight = 0,
		stack = false,
		close = false,
		description = "Pass exclusive to lawyers to show they can represent a suspect",
		client = {
			image = "lawyerpass.png",
		}
	},

	["metalscrap"] = {
		label = "Metal Scrap",
		weight = 100,
		stack = true,
		close = false,
		description = "You can probably make something nice out of this",
		client = {
			image = "metalscrap.png",
		}
	},

	["weed_white-widow"] = {
		label = "White Widow 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g White Widow",
		client = {
			image = "weed_baggy.png",
		}
	},

	["security_card_02"] = {
		label = "Security Card B",
		weight = 0,
		stack = true,
		close = true,
		description = "A security card... I wonder what it goes to",
		client = {
			image = "security_card_02.png",
		}
	},

	["weed_brick"] = {
		label = "Weed Brick",
		weight = 1000,
		stack = true,
		close = true,
		description = "1KG Weed Brick to sell to large customers.",
		client = {
			image = "weed_brick.png",
		}
	},

	["small_tv"] = {
		label = "Small TV",
		weight = 30000,
		stack = false,
		close = true,
		description = "TV",
		client = {
			image = "placeholder.png",
		}
	},

	["labkey"] = {
		label = "Key",
		weight = 500,
		stack = false,
		close = true,
		description = "Key for a lock...?",
		client = {
			image = "labkey.png",
		}
	},

	["tablet"] = {
		label = "Tablet",
		weight = 2000,
		stack = true,
		close = true,
		description = "Expensive tablet",
		client = {
			image = "tablet.png",
		}
	},

	["firstaid"] = {
		label = "First Aid",
		weight = 2500,
		stack = true,
		close = true,
		description = "You can use this First Aid kit to get people back on their feet",
		client = {
			image = "firstaid.png",
		}
	},

	["water_bottle"] = {
		label = "Bottle of Water",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "water_bottle.png",
		}
	},

	["gatecrack"] = {
		label = "Gatecrack",
		weight = 0,
		stack = true,
		close = true,
		description = "Handy software to tear down some fences",
		client = {
			image = "usb_device.png",
		}
	},

	["weed_og-kush_seed"] = {
		label = "OGKush Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of OG Kush",
		client = {
			image = "weed_seed.png",
		}
	},

	["tosti"] = {
		label = "Grilled Cheese Sandwich",
		weight = 200,
		stack = true,
		close = true,
		description = "Nice to eat",
		client = {
			image = "tosti.png",
		}
	},

	["weed_amnesia_seed"] = {
		label = "Amnesia Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Amnesia",
		client = {
			image = "weed_seed.png",
		}
	},

	["weed_ak47"] = {
		label = "AK47 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g AK47",
		client = {
			image = "weed_baggy.png",
		}
	},

	["id_card"] = {
		label = "ID Card",
		weight = 0,
		stack = false,
		close = false,
		description = "A card containing all your information to identify yourself",
		client = {
			image = "id_card.png",
		}
	},

	["weaponlicense"] = {
		label = "Weapon License",
		weight = 0,
		stack = false,
		close = true,
		description = "Weapon License",
		client = {
			image = "weapon_license.png",
		}
	},

	["screwdriverset"] = {
		label = "Toolkit",
		weight = 1000,
		stack = true,
		close = false,
		description = "Very useful to screw... screws...",
		client = {
			image = "screwdriverset.png",
		}
	},

	["walkstick"] = {
		label = "Walking Stick",
		weight = 1000,
		stack = true,
		close = true,
		description = "Walking stick for ya'll grannies out there.. HAHA",
		client = {
			image = "walkstick.png",
		}
	},

	["security_card_01"] = {
		label = "Security Card A",
		weight = 0,
		stack = true,
		close = true,
		description = "A security card... I wonder what it goes to",
		client = {
			image = "security_card_01.png",
		}
	},

	["advancedlockpick"] = {
		label = "Advanced Lockpick",
		weight = 500,
		stack = true,
		close = true,
		description = "If you lose your keys a lot this is very useful... Also useful to open your beers",
		client = {
			event = 'lockpick:use',
			image = "advancedlockpick.png",
		},
	},

	["weed_og-kush"] = {
		label = "OGKush 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g OG Kush",
		client = {
			image = "weed_baggy.png",
		}
	},

	["cleaningkit"] = {
		label = "Cleaning Kit",
		weight = 250,
		stack = true,
		close = true,
		description = "A microfiber cloth with some soap will let your car sparkle again!",
		client = {
			image = "cleaningkit.png",
		}
	},

	["coffee"] = {
		label = "Coffee",
		weight = 200,
		stack = true,
		close = true,
		description = "Pump 4 Caffeine",
		client = {
			image = "coffee.png",
		}
	},

	["thermite"] = {
		label = "Thermite",
		weight = 1000,
		stack = true,
		close = true,
		decay = true,
		degrade = 8800,
		description = "Sometimes you'd wish for everything to burn",
		client = {
			image = "thermite.png",
		}
	},

	["crack_baggy"] = {
		label = "Bag of Crack",
		weight = 0,
		stack = true,
		close = true,
		description = "To get happy faster",
		client = {
			image = "crack_baggy.png",
		}
	},
	["advancedrepairkit"] = {
		label = "Advanced Repairkit",
		weight = 4000,
		stack = true,
		close = true,
		description = "A nice toolbox with stuff to repair your vehicle",
		client = {
			image = "advancedkit.png",
		}
	},

	["diamond"] = {
		label = "Diamond",
		weight = 1000,
		stack = true,
		close = true,
		description = "A diamond seems like the jackpot to me!",
		client = {
			image = "diamond.png",
		}
	},

	["repairkit"] = {
		label = "Repairkit",
		weight = 2500,
		stack = true,
		close = true,
		description = "A nice toolbox with stuff to repair your vehicle",
		client = {
			image = "repairkit.png",
		}
	},

	["snikkel_candy"] = {
		label = "Snikkel",
		weight = 100,
		stack = true,
		close = true,
		description = "Some delicious candy :O",
		client = {
			image = "snikkel_candy.png",
		}
	},

	["meth"] = {
		label = "Meth",
		weight = 100,
		stack = true,
		close = true,
		description = "A baggie of Meth",
		client = {
			image = "meth_baggy.png",
		}
	},

	["sandwich"] = {
		label = "Sandwich",
		weight = 200,
		stack = true,
		close = true,
		description = "Nice bread for your stomach",
		client = {
			image = "sandwich.png",
		}
	},

	["driver_license"] = {
		label = "Drivers License",
		weight = 0,
		stack = false,
		close = false,
		description = "Permit to show you can drive a vehicle",
		client = {
			image = "driver_license.png",
		}
	},

	["firework2"] = {
		label = "Poppelers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework2.png",
		}
	},

	["cokebaggy"] = {
		label = "Bag of Coke",
		weight = 0,
		stack = true,
		close = true,
		description = "To get happy real quick",
		client = {
			image = "cocaine_baggy.png",
		}
	},


	["markedbills"] = {
		label = "Marked Money",
		weight = 1000,
		stack = false,
		close = true,
		description = "Money?",
		client = {
			image = "markedbills.png",
		}
	},

	["goldchain"] = {
		label = "Golden Chain",
		weight = 1500,
		stack = true,
		close = true,
		description = "A golden chain seems like the jackpot to me!",
		client = {
			image = "goldchain.png",
		}
	},

	["firework4"] = {
		label = "Weeping Willow",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework4.png",
		}
	},

	["firework1"] = {
		label = "2Brothers",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework1.png",
		}
	},

	["coke_small_brick"] = {
		label = "Coke Package",
		weight = 350,
		stack = false,
		close = true,
		description = "Small package of cocaine, mostly used for deals and takes a lot of space",
		client = {
			image = "coke_small_brick.png",
		}
	},

	["weed_purple-haze_seed"] = {
		label = "Purple Haze Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Purple Haze",
		client = {
			image = "weed_seed.png",
		}
	},

	["handcuffs"] = {
		label = "Handcuffs",
		weight = 100,
		stack = true,
		close = true,
		description = "Comes in handy when people misbehave. Maybe it can be used for something else?",
		client = {
			image = "handcuffs.png",
		}
	},


	["jerry_can"] = {
		label = "Jerrycan 20L",
		weight = 20000,
		stack = true,
		close = true,
		description = "A can full of Fuel",
		client = {
			image = "jerry_can.png",
		}
	},

	["rolling_paper"] = {
		label = "Rolling Paper",
		weight = 0,
		stack = true,
		close = true,
		description = "Paper made specifically for encasing and smoking tobacco or cannabis.",
		client = {
			image = "rolling_paper.png",
		}
	},

	["cryptostick"] = {
		label = "Crypto Stick",
		weight = 200,
		stack = false,
		close = true,
		description = "Why would someone ever buy money that doesn't exist.. How many would it contain..?",
		client = {
			image = "cryptostick.png",
		}
	},

	["wine"] = {
		label = "Wine",
		weight = 300,
		stack = true,
		close = false,
		description = "Some good wine to drink on a fine evening",
		client = {
			image = "wine.png",
		}
	},

	["goldbar"] = {
		label = "Gold Bar",
		weight = 7000,
		stack = true,
		close = true,
		description = "Looks pretty expensive to me",
		client = {
			image = "goldbar.png",
		}
	},

	["rolex"] = {
		label = "Golden Watch",
		weight = 1500,
		stack = true,
		close = true,
		description = "A golden watch seems like the jackpot to me!",
		client = {
			image = "rolex.png",
		}
	},

	["nitrous"] = {
		label = "Nitrous",
		weight = 1000,
		stack = true,
		close = true,
		description = "Speed up, gas pedal! :D",
		client = {
			image = "nitrous.png",
		}
	},

	["plastic"] = {
		label = "Plastic",
		weight = 100,
		stack = true,
		close = false,
		description = "RECYCLE! - Greta Thunberg 2019",
		client = {
			image = "plastic.png",
		}
	},

	["armor"] = {
		label = "Armor",
		weight = 5000,
		stack = true,
		close = true,
		description = "Some protection won't hurt... right?",
		client = {
			image = "armor.png",
		}
	},

	["pinger"] = {
		label = "Pinger",
		weight = 1000,
		stack = true,
		close = true,
		description = "With a pinger and your phone you can send out your location",
		client = {
			image = "pinger.png",
		}
	},


	["toaster"] = {
		label = "Toaster",
		weight = 18000,
		stack = false,
		close = true,
		description = "Toast",
		client = {
			image = "placeholder.png",
		}
	},

	["weed_skunk_seed"] = {
		label = "Skunk Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of Skunk",
		client = {
			image = "weed_seed.png",
		}
	},

	["xtcbaggy"] = {
		label = "Bag of XTC",
		weight = 0,
		stack = true,
		close = true,
		description = "Pop those pills baby",
		client = {
			image = "xtc_baggy.png",
		}
	},

	["rubber"] = {
		label = "Rubber",
		weight = 100,
		stack = true,
		close = false,
		description = "Rubber, I believe you can make your own rubber ducky with it :D",
		client = {
			image = "rubber.png",
		}
	},

	["radioscanner"] = {
		label = "Radio Scanner",
		weight = 1000,
		stack = true,
		close = true,
		description = "With this you can get some police alerts. Not 100% effective however",
		client = {
			image = "radioscanner.png",
		}
	},

	["twerks_candy"] = {
		label = "Twerks",
		weight = 100,
		stack = true,
		close = true,
		description = "Some delicious candy :O",
		client = {
			image = "twerks_candy.png",
		}
	},

	["empty_evidence_bag"] = {
		label = "Empty Evidence Bag",
		weight = 0,
		stack = true,
		close = false,
		description = "Used a lot to keep DNA from blood, bullet shells and more",
		client = {
			image = "evidence.png",
		}
	},

	["beer"] = {
		label = "Beer",
		weight = 500,
		stack = true,
		close = true,
		description = "Nothing like a good cold beer!",
		client = {
			image = "beer.png",
		}
	},

	["drill"] = {
		label = "Drill",
		weight = 20000,
		stack = true,
		close = false,
		description = "The real deal...",
		client = {
			image = "drill.png",
		}
	},

	["kurkakola"] = {
		label = "Cola",
		weight = 500,
		stack = true,
		close = true,
		description = "For all the thirsty out there",
		client = {
			image = "cola.png",
		}
	},

	["lighter"] = {
		label = "Lighter",
		weight = 0,
		stack = true,
		close = true,
		description = "On new years eve a nice fire to stand next to",
		client = {
			image = "lighter.png",
		}
	},
	["electronickit"] = {
		label = "Electronic Kit",
		weight = 100,
		stack = true,
		close = true,
		description = "If you've always wanted to build a robot you can maybe start here. Maybe you'll be the new Elon Musk?",
		client = {
			image = "electronickit.png",
		}
	},


	["antipatharia_coral"] = {
		label = "Antipatharia",
		weight = 1000,
		stack = true,
		close = true,
		description = "Its also known as black corals or thorn corals",
		client = {
			image = "antipatharia_coral.png",
		}
	},

	["diving_fill"] = {
		label = "Diving Tube",
		weight = 3000,
		stack = false,
		close = true,
		client = {
			image = "diving_tube.png",
		}
	},

	["binoculars"] = {
		label = "Binoculars",
		weight = 600,
		stack = true,
		close = true,
		description = "Sneaky Breaky...",
		client = {
			image = "binoculars.png",
		}
	},

	["10kgoldchain"] = {
		label = "10k Gold Chain",
		weight = 2000,
		stack = true,
		close = true,
		description = "10 carat golden chain",
		client = {
			image = "10kgoldchain.png",
		}
	},

	["aluminium"] = {
		label = "Aluminium",
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "aluminium.png",
		}
	},

	["heavyarmor"] = {
		label = "Heavy Armor",
		weight = 5000,
		stack = true,
		close = true,
		description = "Some protection won't hurt... right?",
		client = {
			image = "armor.png",
		}
	},


	["weed_purple-haze"] = {
		label = "Purple Haze 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g Purple Haze",
		client = {
			image = "weed_baggy.png",
		}
	},

	["firework3"] = {
		label = "WipeOut",
		weight = 1000,
		stack = true,
		close = true,
		description = "Fireworks",
		client = {
			image = "firework3.png",
		}
	},

	["ifaks"] = {
		label = "ifaks",
		weight = 200,
		stack = true,
		close = true,
		description = "ifaks for healing and a complete stress remover.",
		client = {
			image = "ifaks.png",
		}
	},

	["coke_brick"] = {
		label = "Coke Brick",
		weight = 1000,
		stack = false,
		close = true,
		description = "Heavy package of cocaine, mostly used for deals and takes a lot of space",
		client = {
			image = "coke_brick.png",
		}
	},

	["filled_evidence_bag"] = {
		label = "Evidence Bag",
		weight = 200,
		stack = false,
		close = false,
		description = "A filled evidence bag to see who committed the crime >:(",
		client = {
			image = "evidence.png",
		}
	},

	["certificate"] = {
		label = "Certificate",
		weight = 0,
		stack = true,
		close = true,
		description = "Certificate that proves you own certain stuff",
		client = {
			image = "certificate.png",
		}
	},

	["printerdocument"] = {
		label = "Document",
		weight = 500,
		stack = false,
		close = true,
		description = "A nice document",
		client = {
			image = "printerdocument.png",
		}
	},

	["weed_amnesia"] = {
		label = "Amnesia 2g",
		weight = 200,
		stack = true,
		close = false,
		description = "A weed bag with 2g Amnesia",
		client = {
			image = "weed_baggy.png",
		}
	},

	["weed_ak47_seed"] = {
		label = "AK47 Seed",
		weight = 0,
		stack = true,
		close = true,
		description = "A weed seed of AK47",
		client = {
			image = "weed_seed.png",
		}
	},

	["painkillers"] = {
		label = "Painkillers",
		weight = 0,
		stack = true,
		close = true,
		description = "For pain you can't stand anymore, take this pill that'd make you feel great again",
		client = {
			image = "painkillers.png",
		}
	},
	['lscm'] = {
		label = 'Golf Club Membership',
		weight = 1,
		stack = false,
		close = true,
		description = 'The Most Prestigious Golf Club'
	},
	['notebook'] = {
		label = 'Notebook',
		weight = 35,
		stack = false,
		close = true,
		description = 'Notebook for writing in'
	},
	["scrunchie"] = {
		label = "Scrunchie",
		weight = 0,
		stack = true,
		close = true,
		description = "Use this shit on your hair.",
	},
	-------pickles crafting---------
	['blueprint_advancedw'] = {
		label = 'Advanced Weapon blueprint',
		weight = 10,
		stack = true,
		close = true,
		description = 'Used for crafting.'
	},

	-----crafting items------
	["aluminumoxide"] = {
		label = "Aluminum Powder",
		weight = 100,
		stack = true,
		close = false,
		decay = true,
		degrade = 4800,
		description = "Some powder to mix with",
		client = {
			image = "aluminumoxide.png",
		}
	},
	["trigger"] = {
		label = "trigger",
		weight = 100,
		stack = true,
		close = true,
		description = "Nothing like a good old trigger!",
		client = {
			image = "trigger.png",
		}
	},
	["ironoxide"] = {
		label = "Iron Powder",
		weight = 100,
		stack = true,
		close = false,
		decay = true,
		degrade = 4800,
		description = "Some powder to mix with.",
		client = {
			image = "ironoxide.png",
		}
	},
	["scrap_metal"] = {
		label = "Scrap Metal",
		weight = 100,
		stack = true,
		close = true,
		description = "A Piece Of Scrap Metal",
		client = {
			image = "scrap_metal.png",
		}
	},
	["spring"] = {
		label = "spring",
		weight = 50,
		stack = true,
		close = true,
		description = "Springy little metal things",
	},
	["md_screw"] = {
		label = "Screw",
		weight = 10,
		stack = true,
		close = true,
		description = "Springy little metal things",
	},

	["lead"] = {
		label = "lead",
		weight = 100,
		stack = true,
		close = false,
		description = "Nice piece of metal that you can probably use for something",
		client = {
			image = "lead.png",
		}
	},
	["newoil"] = {
		label = "Car Oil",
		weight = 10,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "caroil.png",
		}
	},
	["barrel"] = {
		label = "Barrel",
		weight = 10,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "at_barrel.png",
		}
	},
	["weaponkit"] = {
		label = "Weaponkit",
		weight = 10,
		stack = true,
		close = false,
		description = "",
		client = {
			image = "weaponkit.png",
		}
	},

		-- // Business Items // --

	['business_tempitem'] = {
		label = "how did you get this?",
		weight = 0,
		stack = true,
		close = true,
		consume = 0,
		server = {
			export = 'Renewed-Businesses.useItem',
		}
	},

	-- Kitchen Tools --

	['kitchenknife'] = {
		label = 'Kitchen Knife',
		weight = 50,
		shopType = 'general',
		price = 10,
	},

	['cleaver'] = {
		label = 'Meat Cleaver',
		weight = 50,
		shopType = 'general',
		price = 10,
	},

	['blender'] = {
		label = 'Blender',
		weight = 50,
		shopType = 'general',
		price = 10,
	},

	['whisk'] = {
		label = 'Whisks',
		weight = 50,
		shopType = 'general',
		price = 10,
	},

	['slicer'] = {
		label = 'Slicer',
		weight = 50,
		shopType = 'general',
		price = 10,
	},

	['potatopusher'] = {
		label = 'Potato Pusher',
		weight = 50,
		shopType = 'general',
		price = 10,
	},

	['peeler'] = {
		label = 'Peeler',
		weight = 50,
		shopType = 'general',
		price = 10,
	},

	['scooper'] = {
		label = 'Scooper',
		weight = 50,
		shopType = 'general',
		price = 10,
	},

	-- Fruit --

	['strawberry'] = {
		label = 'Strawberries',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['cutstrawberry'] = {
		label = 'Cut Strawberries',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['strawberryjuice'] = {
		label = 'Strawberry Juice',
		weight = 50,
		foodType = 'drink',
		nutrition = {
			healthy = 3,
			thirst = 3,
		},
	},

	['apples'] = {
		label = 'Apples',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['cutapples'] = {
		label = 'Cut Apples',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['applejuice'] = {
		label = 'Apple Juice',
		weight = 50,
		foodType = 'drink',
		nutrition = {
			healthy = 3,
			thirst = 3,
		},
	},

	['pickle'] = {
		label = 'Pickles',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['cutpickle'] = {
		label = 'Cut Pickles',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['pineapple'] = {
		label = 'Pineapples',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['cutpineapple'] = {
		label = 'Cut Pineapple',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['pineapplejuice'] = {
		label = 'Pineapple Juice',
		weight = 50,
		foodType = 'drink',
		nutrition = {
			healthy = 3,
			thirst = 3,
		},
	},

	['orange'] = {
		label = 'Oranges',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['cutorange'] = {
		label = 'Cut Oranges',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['orangejuice'] = {
		label = 'Orange Juice',
		weight = 50,
		foodType = 'drink',
		nutrition = {
			healthy = 3,
			thirst = 3,
		},
	},

	['blueberry'] = {
		label = 'Blueberries',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['cutblueberry'] = {
		label = 'Cut Blueberries',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['blueberryjuice'] = {
		label = 'Blueberry Juice',
		weight = 50,
		foodType = 'drink',
		nutrition = {
			healthy = 3,
			thirst = 3,
		},
	},

	['boba'] = {
		label = 'Boba',
		weight = 50,
		foodType = 'food',
		shopType = 'farmers',
		price = 10,
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['lime'] = {
		label = 'Limes',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['cutlime'] = {
		label = 'Cut Limes',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['limejuice'] = {
		label = 'Lime Juice',
		weight = 50,
		foodType = 'drink',
		nutrition = {
			healthy = 3,
			thirst = 3,
		},
	},

	['banana'] = {
		label = 'Bananas',
		weight = 50,
		shopType = 'farmers',
		price = 10,
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['cutbananas'] = {
		label = 'Cut Bananas',
		weight = 50,
		foodType = {'food', 'drink'},
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['grapes'] = {
		label = 'Grapes',
		weight = 50,
		shopType = 'farmers',
		price = 10,
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['grapejuice'] = {
		label = 'Grape Juice',
		weight = 50,
		foodType = 'drink',
		nutrition = {
			healthy = 3,
			thirst = 3,
		},
	},

	['lemons'] = {
		label = 'Lemons',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['lemonjuice'] = {
		label = 'Lemon Juice',
		weight = 50,
		foodType = 'drink',
		nutrition = {
			healthy = 3,
			thirst = 3,
		},
	},

	['cutlemon'] = {
		label = 'Cut Lemon',
		weight = 50,
		foodType = 'drink',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},


	['kiwi'] = {
		label = 'Kiwi',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['cutkiwi'] = {
		label = 'Cut Kiwi',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['cherry'] = {
		label = 'Cherries',
		weight = 50,
		shopType = 'farmers',
		price = 10,
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['cherryjuice'] = {
		label = 'Cherry Juice',
		weight = 50,
		foodType = 'drink',
		nutrition = {
			healthy = 3,
			thirst = 3,
		},
	},

	['lettuce'] = {
		label = 'Lettuce Head',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['choplettuce'] = {
		label = 'Chopped Lettuce',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['tomato'] = {
		label = 'Tomatos',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['choptomato'] = {
		label = 'Chopped Tomato',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['slicedtomato'] = {
		label = 'Tomato Slices',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['potatoes'] = {
		label = 'Potatoes',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['potatoslice'] = {
		label = 'Sliced Potatoes',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			salt = 2,
			hunger = 3,
		},
	},

	['potatoskins'] = {
		label = 'Potato Skins',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			salt = 2,
			hunger = 3,
		},
	},

	['choppotato'] = {
		label = 'Chopped Potatoes',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			salt = 2,
			hunger = 3,
		},
	},

	['squash'] = {
		label = 'Squash',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['chopsquash'] = {
		label = 'Chopped Squash',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['spinach'] = {
		label = 'Spinach',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['chopspinach'] = {
		label = 'Chopped Spinach',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['celery'] = {
		label = 'Celery',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['chopcelery'] = {
		label = 'Chopped Celery',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['redpeppers'] = {
		label = 'Red Peppers',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['slicedredpepper'] = {
		label = 'Sliced Red Pepper',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['chopredpepper'] = {
		label = 'Chopped Red Pepper',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['greenpeppers'] = {
		label = 'Green Peppers',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['slicedgreenpepper'] = {
		label = 'Sliced Green Pepper',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['chopgreenpepper'] = {
		label = 'Chopped Green Pepper',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['hotpepper'] = {
		label = 'Jalapeno Peppers',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['chophotpepper'] = {
		label = 'Chopped Jalapeno Pepper',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['carrots'] = {
		label = 'Carrots',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['chopcarrots'] = {
		label = 'Chopped Carrots',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['cucumbers'] = {
		label = 'Cucumbers',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['chopcucumbers'] = {
		label = 'Chopped Cucumbers',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['peas'] = {
		label = 'Peas',
		weight = 50,
		shopType = 'farmers',
		price = 10,
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['greenbeans'] = {
		label = 'Grean Beans',
		weight = 50,
		shopType = 'farmers',
		price = 10,
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['corn'] = {
		label = 'Corn',
		weight = 50,
		shopType = 'farmers',
		price = 10,
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['cobcorn'] = {
		label = 'Corn on the Cob',
		weight = 50,
		shopType = 'farmers',
		price = 10,
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	['broccoli'] = {
		label = 'Broccoli',
		weight = 50,
		shopType = 'farmers',
		price = 10,
	},

	['chopbroccoli'] = {
		label = 'Chopped Broccoli',
		weight = 50,
		foodType = 'food',
		nutrition = {
			healthy = 3,
			hunger = 3,
		},
	},

	-- // Dairy // --

	['milk'] = {
		label = 'Milk',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = {'food', 'drink'},
		nutrition = {
			dairy = 3,
			thirst = 3,
		},
	},

	['eggs'] = {
		label = 'Eggs',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			protein = 2,
			hunger = 3,
		},
	},

	['butter'] = {
		label = 'Butter',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['condensedmilk'] = {
		label = 'Condensed Milk',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['yogurt'] = {
		label = 'Yogurt',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = {'food', 'drink'},
		nutrition = {
			dairy = 3,
			hunger = 3,
			thirst = 2,
		},
	},

	['mozzarella'] = {
		label = 'Mozzarella Cheese',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
	},

	['cubemozzarella'] = {
		label = 'Cubbed Mozzarella Cheese',
		weight = 50,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['stringmozzarella'] = {
		label = 'String Mozzarella Cheese',
		weight = 50,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['provolone'] = {
		label = 'Provolone Cheese',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
	},

	['cubeprovolone'] = {
		label = 'Cubbed Provolone Cheese',
		weight = 50,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['stringprovolone'] = {
		label = 'String Provolone Cheese',
		weight = 50,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['cheddar'] = {
		label = 'Cheddar Cheese',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
	},

	['cubecheddar'] = {
		label = 'Cubbed Cheddar Cheese',
		weight = 50,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['stringcheddar'] = {
		label = 'String Cheddar Cheese',
		weight = 50,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['bluecheese'] = {
		label = 'Blue Cheese',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['parmesan'] = {
		label = 'Parmesan Cheese',
		weight = 50,
		shopType = 'dairy',
		price = 10,
	},

	['parmesanflakes'] = {
		label = 'Parmesan Flakes',
		weight = 50,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['ricotta'] = {
		label = 'Ricotta Cheese',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['creamcheese'] = {
		label = 'Cream Cheese',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['gouda'] = {
		label = 'Cream Cheese',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['cottagecheese'] = {
		label = 'Cottage Cheese',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['swiss'] = {
		label = 'Swiss Cheese',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = 'food',
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	['icecream'] = {
		label = 'Ice Cream',
		weight = 50,
		shopType = 'dairy',
		price = 10,
		foodType = {'food', 'drink'},
		nutrition = {
			dairy = 3,
			hunger = 3,
		},
	},

	-- // Meat // --


	['bologna'] = {
		label = 'Bologna',
		weight = 50,
		shopType = 'butcher',
		price = 10,
		foodType = 'food',
	},


	['slicedbologna'] = {
		label = 'Sliced Bologna',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 5,
		},
	},

	['wholeham'] = {
		label = 'Whole Ham',
		weight = 50,
		shopType = 'butcher',
		price = 10,
		foodType = 'food',
	},

	['bacon'] = {
		label = 'Bacon Strips',
		weight = 50,
		foodType = 'food',
		shopType = 'butcher',
		price = 10,
		nutrition = {
			protein = 3,
			hunger = 5,
		},
	},

	['baconbits'] = {
		label = 'Bacon Bits',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 5,
		},
	},

	['meatslab'] = {
		label = 'Slab of Meat',
		weight = 50,
		shopType = 'butcher',
		price = 10,
		foodType = 'food',
	},

	['nystrip'] = {
		label = 'Raw NY Stip',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 4,
			hunger = 8,
		},
	},

	['filet'] = {
		label = 'Raw Beef Tenderloin',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 7,
		},
	},

	['ribs'] = {
		label = 'Ribs',
		weight = 50,
		shopType = 'butcher',
		price = 10,
		foodType = 'food',
		nutrition = {
			protein = 4,
			hunger = 8,
		},
	},

	['hotdog'] = {
		label = 'Hotdogs',
		weight = 50,
		shopType = 'butcher',
		price = 10,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 4,
		},
	},

	['roastbeef'] = {
		label = 'Roast Beef',
		weight = 50,
		shopType = 'butcher',
		price = 10,
		foodType = 'food',
		nutrition = {
			protein = 4,
			hunger = 6,
		},
	},

	['slicedham'] = {
		label = 'Sliced Ham',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 6,
		},
	},

	['dicedham'] = {
		label = 'Diced Ham',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 4,
		},
	},

	['frozennuggets'] = {
		label = 'Frozen Nuggets',
		weight = 50,
		shopType = 'butcher',
		price = 10,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 6,
		},
	},

	['frozenchickenpatty'] = {
		label = 'Frozen Chicken Patty',
		weight = 50,
		shopType = 'butcher',
		price = 10,
		foodType = 'food',
		nutrition = {
			protein = 4,
			hunger = 5,
		},
	},

	['frozenbeefpatty'] = {
		label = 'Beef Patty',
		weight = 50,
		shopType = 'butcher',
		price = 10,
		foodType = 'food',
		nutrition = {
			protein = 4,
			hunger = 6,
		},
	},

	['pepperoni'] = {
		label = 'Pepperoni',
		weight = 50,
		shopType = 'butcher',
		price = 10,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 4,
		},
	},

	['packagedchicken'] = {
		label = 'Packaged Chicken',
		weight = 50,
		shopType = 'butcher',
		price = 10,
		foodType = 'food',
	},

	['venison'] = {
		label = 'Hunting Meat',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 6,
			hunger = 13,
		},
	},

	['chickenstrips'] = {
		label = 'Chicken Strips',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 4,
		},
	},

	['chickenwings'] = {
		label = 'Chicken Wings',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 4,
			hunger = 5,
		},
	},

	['catfishfilet'] = {
		label = 'Catfish Filet',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 7,
		},
	},

	['redfishfilet'] = {
		label = 'Redfish Filet',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 7,
		},
	},

	['salomfilet'] = {
		label = 'Salmon Filet',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 6,
		},
	},

	['tunafilet'] = {
		label = 'Tuna Filet',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 8,
		},
	},

	['stripedbassfilet'] = {
		label = 'Stripped Bass Filet',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 5,
		},
	},

	['rawsquid'] = {
		label = 'Raw Squid',
		weight = 50,
		foodType = 'food',
		nutrition = {
			protein = 3,
			hunger = 4,
		},
	},

	-- // Bread/Carbs  // --

	['breadloaf'] = {
		label = 'Bread Loaf',
		weight = 50,
		foodType = 'food',
		shopType = 'bakery',
		price = 10,
	},

	['flour'] = {
		label = 'Flour',
		weight = 50,
		foodType = 'food',
		shopType = 'bakery',
		price = 10,
	},

	['hotdogbun'] = {
		label = 'Hot Dog Buns',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 4,
			hunger = 3,
		},
	},

	['burgerbuns'] = {
		label = 'Burger Buns',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 4,
			hunger = 4,
		},
	},

	['flatbread'] = {
		label = 'Flat Bread',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 4,
			hunger = 3,
		},
	},

	['bagel'] = {
		label = 'Bagel',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 4,
			hunger = 3,
		},
	},

	['pizzadough'] = {
		label = 'Yeast',
		weight = 50,
		foodType = 'food',
		nutrition = {
			carbs = 2,
			hunger = 6,
		},
	},

	['sandwichbread'] = {
		label = 'Sandwich Bread',
		weight = 50,
		foodType = 'food',
		nutrition = {
			carbs = 3,
			hunger = 2,
		},
	},

	['fettuccine'] = {
		label = 'Fettuccine Noodles',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 5,
			hunger = 4,
		},
	},

	['spaghetti'] = {
		label = 'Spaghetti Noodles',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 5,
			hunger = 4,
		},
	},

	['tortellini'] = {
		label = 'Tortellini Noodles',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 5,
			hunger = 4,
		},
	},

	['linguine'] = {
		label = 'Linguine Noodles',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 5,
			hunger = 4,
		},
	},

	['lasagna'] = {
		label = 'Lasagna Noodles',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 5,
			hunger = 4,
		},
	},

	['macaroni'] = {
		label = 'Macaroni Noodles',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 4,
			hunger = 5,
		},
	},

	['rigatoni'] = {
		label = 'Macaroni Noodles',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 4,
			hunger = 5,
		},
	},

	['ramen'] = {
		label = 'Ramen Noodles',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 4,
			hunger = 3,
		},
	},

	['rice'] = {
		label = 'Rice',
		weight = 50,
		shopType = 'bakery',
		price = 10,
		foodType = 'food',
		nutrition = {
			carbs = 4,
			hunger = 4,
		},
	},

	-- // General Market // --

	['coffeebean'] = {
		label = 'Coffee Beans',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			sugar = 4,
			thirst = 5,
			seasoning = 2,
		},
	},

	['ketchup'] = {
		label = 'Ketchup',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			hunger = 2,
			seasoning = 2,
		},
	},

	['mustard'] = {
		label = 'Mustard',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			hunger = 2,
			seasoning = 2,
		},
		client = {
			status = { hunger = 25000, thirst = 25000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_food_mustard`, pos = vec3(0.01, 0.0, -0.07), rot = vec3(1.0, 1.0, -1.5) },
			usetime = 2500,
			notification = 'You.. drank mustard'
		}
	},

	['bbqsauce'] = {
		label = 'BBQ Sauce',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			hunger = 2,
			seasoning = 4,
		},
	},

	['mint'] = {
		label = 'Mint',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			hunger = 2,
			seasoning = 3,
		},
	},

	['sauce'] = {
		label = 'Generic Sauce',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			hunger = 3,
			seasoning = 2,
		},
	},

	['chips'] = {
		label = 'Potato Chips',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			hunger = 3,
		},
	},

	['chocolatecandies'] = {
		label = 'Chocolate Candy',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			sugar = 3,
			seasoning = 1,
			hunger = 1,
		},
	},

	['chocolatesyrup'] = {
		label = 'Chocolate Syrup',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			sugar = 3,
			seasoning = 1,
			hunger = 1,
		},
	},

	['sprinkles'] = {
		label = 'Assorted Sprinkles',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			sugar = 2,
			seasoning = 1,
			hunger = 1,
		},
	},

	['candy'] = {
		label = 'Assorted Candies',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			sugar = 2,
			seasoning = 1,
			hunger = 1,
		},
	},

	['sugar'] = {
		label = 'Sugar',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			sugar = 2,
			seasoning = 2,
			hunger = 1,
		},
	},

	['brownsugar'] = {
		label = 'Brown Sugar',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			sugar = 2,
			seasoning = 2,
			hunger = 1,
		},
	},


	['salt'] = {
		label = 'Salt',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 2,
			hunger = 1,
		},
	},

	['pepper'] = {
		label = 'Pepper',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 2,
			hunger = 1,
		},
	},

	['basil'] = {
		label = 'Basil',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 2,
			hunger = 1,
		},
	},

	['chilipowder'] = {
		label = 'Chili Powder',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 3,
			hunger = 1,
		},
	},

	['cinnamon'] = {
		label = 'Cinnamon',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 3,
			hunger = 1,
		},
	},

	['garlicpowder'] = {
		label = 'Garlic Powder',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 3,
			hunger = 1,
		},
	},

	['lemonpeper'] = {
		label = 'Lemon Pepper',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 4,
			hunger = 1,
		},
	},

	['nutmeg'] = {
		label = 'Nutmeg',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 2,
			hunger = 1,
		},
	},

	['onionpowder'] = {
		label = 'Onion Powder',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 1,
			hunger = 1,
		},
	},

	['oregano'] = {
		label = 'Oregano',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 3,
			hunger = 1,
		},
	},

	['paprika'] = {
		label = 'Paprika',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 2,
			hunger = 1,
		},
	},

	['pepperflakes'] = {
		label = 'Red Pepper Flakes',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 3,
			hunger = 1,
		},
	},

	['thyme'] = {
		label = 'Thyme',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 1,
			hunger = 1,
		},
	},

	['curry'] = {
		label = 'Curry',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'food',
		nutrition = {
			seasoning = 2,
			hunger = 1,
		},
	},



	-- // Alchol // --

	['gin'] = {
		label = 'Gin',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'drink',
		nutrition = {
			alcohol = 5,
			thirst = 3,
		},
	},

	['vodka'] = {
		label = 'Vodka',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'drink',
		nutrition = {
			alcohol = 5,
			thirst = 3,
		},
	},

	['whiskey'] = {
		label = 'Whiskey',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'drink',
		nutrition = {
			alcohol = 5,
			thirst = 3,
		},
	},

	['cognac'] = {
		label = 'Cognac',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'drink',
		nutrition = {
			alcohol = 5,
			thirst = 3,
		},
	},

	['rum'] = {
		label = 'Rum',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'drink',
		nutrition = {
			alcohol = 5,
			thirst = 3,
		},
	},

	['olives'] = {
		label = 'Olives',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = {'food', 'drink'},
		nutrition = {
			alcohol = 5,
			thirst = 3,
			hunger = 2
		},
	},

	['tonic'] = {
		label = 'Tonic',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'drink',
		nutrition = {
			alcohol = 5,
			thirst = 3,
		},
	},

	['carbonatedwater'] = {
		label = 'Cabonated Water',
		weight = 50,
		shopType = 'general',
		price = 10,
		foodType = 'drink',
		nutrition = {
			thirst = 7,
		},
	},

	["grape"] = {
		label = "Grape",
		weight = 100,
		stack = true,
		close = false,
		description = "Mmmmh yummie, grapes",
		client = {
			image = "grape.png",
		}
	},

	["spraycan"] = {
		label = "Spray Can",
		weight = 1000,
		stack = false,
		close = true,
		description = "Spray Can",
		client = {
			image = "spraycan.png",
		}
	},

	["sprayremover"] = {
		label = "Spray Remover",
		weight = 100,
		stack = false,
		close = true,
		description = "Spray Remover",
		client = {
			image = "sprayremover.png",
		}
	},

	["fitbit"] = {
		label = "Fitbit",
		weight = 500,
		stack = false,
		close = true,
		description = "I like fitbit",
		client = {
			image = "fitbit.png",
		}
	},

	["tunerlaptop"] = {
		label = "Tunerchip",
		weight = 2000,
		stack = false,
		close = true,
		description = "With this tunerchip you can get your car on steroids... If you know what you're doing",
		client = {
			image = "tunerchip.png",
		}
	},

	["jewellerybox"] = {
		label = "Jewellery Box",
		weight = 1000,
		stack = true,
		close = true,
		description = "Box full of Jewellery",
		client = {
			image = "jewellerybox.png",
		}
	},

	--------- Lation laundering------
	['warehouse_key'] = {
		label = 'Warehouse Key',
		weight = 25,
	},

	['uncounted_money'] = {
		label = 'Uncounted Money',
	},

	--------Lab Pets -------
	['pethealth'] = {
		label = 'Pet Health',
		weight = 5,
		stack = true,
		close = true,
		description = 'Health for your pet.',
	},
	['petfood'] = {
		label = 'Pet Food',
		weight = 5,
		stack = true,
		close = true,
		description = 'Food for your pet.',
	},
	['petthirst'] = {
		label = 'Pet Thirst',
		weight = 5,
		stack = true,
		close = true,
		description = 'Drink for your pet.',
	},
	['petrope'] = {
		label = 'Pet Lead',
		weight = 5,
		stack = false,
		close = true,
		description = 'Used for walking your pet.',
	},
	['petball'] = {
		label = 'Pet Ball',
		weight = 5,
		stack = false,
		close = true,
		description = 'Used to play with your pet.',
	},

	-------food truck-------
	['food_truck'] = {
		label = 'Install Kitchen',
		weight = 800,
		stack = false,
		close = true,
		consume = 1,
		client = {
			export = 'dd5m_foodtrucks.install'
		}
	},
    ['basic_recipes'] = {
		label = 'Basic Recipe Book',
		weight = 80,
	},
	['ft_cola'] = {
		label = 'eCola(Food Truck)',
		weight = 350,
		client = {
			status = { thirst = 2000000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with cola'
		}
	},

	['ft_horchata'] = {
		label = 'Horchata(Food Truck)',
		weight = 350,
		client = {
			status = { thirst = 2000000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with Horchata'
		}
	},

	['ft_italiansoda'] = {
		label = 'Italian Soda(Food Truck)',
		weight = 350,
		client = {
			status = { thirst = 2000000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with Italian Soda'
		}
	},

	['ft_strawberryjuice'] = {
		label = 'Strawberry Juice(Food Truck)',
		weight = 350,
		client = {
			status = { thirst = 2000000 },
			anim = { dict = 'mp_player_intdrink', clip = 'loop_bottle' },
			prop = { model = `prop_ecola_can`, pos = vec3(0.01, 0.01, 0.06), rot = vec3(5.0, 5.0, -180.5) },
			usetime = 2500,
			notification = 'You quenched your thirst with Strawberry Juice'
		}
	},

	['ft_burrito'] = {
		label = 'Burrito(Food Truck)',
		weight = 220,
		client = {
			status = { hunger = 2000000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious Burrito'
		},
	},

	['ft_quesadilla'] = {
		label = 'Quesadilla(Food Truck)',
		weight = 220,
		client = {
			status = { hunger = 2000000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious Quesadilla'
		},
	},

	['ft_spaghetti'] = {
		label = 'Spaghetti(Food Truck)',
		weight = 220,
		client = {
			status = { hunger = 2000000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious Spaghetti'
		},
	},

	['ft_pizza'] = {
		label = 'Pizza(Food Truck)',
		weight = 220,
		client = {
			status = { hunger = 2000000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious Pizza'
		},
	},

	['ft_ramen'] = {
		label = 'Ramen(Food Truck)',
		weight = 220,
		client = {
			status = { hunger = 2000000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious Ramen'
		},
	},

	['ft_potstickers'] = {
		label = 'Potstickers(Food Truck)',
		weight = 220,
		client = {
			status = { hunger = 2000000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious Potstickers'
		},
	},

	['ft_burger'] = {
		label = 'Burger(Food Truck)',
		weight = 220,
		client = {
			status = { hunger = 2000000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious Burger'
		},
	},

	['ft_cheesesticks'] = {
		label = 'Fried Cheesesticks(Food Truck)',
		weight = 220,
		client = {
			status = { hunger = 2000000 },
			anim = 'eating',
			prop = 'burger',
			usetime = 2500,
			notification = 'You ate a delicious Fried Cheesesticks'
		},
	},

	["laptop_blue"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		decay = true,
		degrade = 4800,
		description = "A laptop that you got from Ramsay",
		client = {
			image = "laptop_blue.png",
		}
	},

	["usb_red"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		decay = true,
		degrade = 4800,
		description = "A red USB flash drive",
		client = {
			image = "usb_red.png",
		}
	},

	["nightvision"] = {
		label = "Night Vision Goggles",
		weight = 6000,
		stack = true,
		close = false,
		description = "These allow you to see in the dark",
		client = {
			image = "nightvision.png",
		}
	},

	["usb_blue"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		decay = true,
		degrade = 4800,
		description = "A blue USB flash drive",
		client = {
			image = "usb_blue.png",
		}
	},

	["explosive"] = {
		label = "Explosive",
		weight = 5000,
		stack = true,
		close = true,
		description = "An improvised explosive of fireworks and thermite",
		client = {
			image = "explosive.png",
		}
	},

	["laptop_red"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		decay = true,
		degrade = 4800,
		description = "A laptop that you got from Plague",
		client = {
			image = "laptop_red.png",
		}
	},

	["usb_green"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		decay = true,
		degrade = 4800,
		description = "A green USB flash drive",
		client = {
			image = "usb_green.png",
		}
	},

	["usb_gold"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		decay = true,
		degrade = 4800,
		description = "A gold USB flash drive",
		client = {
			image = "usb_gold.png",
		}
	},

	["laptop_gold"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		decay = true,
		degrade = 4800,
		description = "A laptop that you got from Trinity",
		client = {
			image = "laptop_gold.png",
		}
	},

	["laptop_green"] = {
		label = "Laptop",
		weight = 2500,
		stack = false,
		close = true,
		decay = true,
		degrade = 4800,
		description = "A laptop that you got from Ph03nix",
		client = {
			image = "laptop_green.png",
		}
	},

	["usb_grey"] = {
		label = "USB Drive",
		weight = 1000,
		stack = true,
		close = false,
		decay = true,
		degrade = 4800,		description = "A grey USB flash drive",
		client = {
			image = "usb_grey.png",
		}
	},

	----hunting-----
	["hunting_stove"] = {
		label = "Hunting Stove",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_mtlion_meat"] = {
		label = "Lion Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_mtlion_skin"] = {
		label = "Lion Skin",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_deer_skin"] = {
		label = "Deer Skin",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_deer_meat"] = {
		label = "Deer Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_boar_skin"] = {
		label = "Boar Skin",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_boar_meat"] = {
		label = "Boar Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_coyote_skin"] = {
		label = "Coyote Skin",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_coyote_meat"] = {
		label = "Coyote Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_chickenhawk_skin"] = {
		label = "Chickenhawk Skin",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_chickenhawk_meat"] = {
		label = "Chickenhawk Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_rabbit_skin"] = {
		label = "Rabbit Skin",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_rabbit_meat"] = {
		label = "Rabbit Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_crow_skin"] = {
		label = "Crow Skin",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_crow_meat"] = {
		label = "Crow Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_pigeon_skin"] = {
		label = "Pigeon Skin",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_pigeon_meat"] = {
		label = "Pigeon Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_seagull_skin"] = {
		label = "Seagull Skin",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_seagull_meat"] = {
		label = "Seagull Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_deer_meat_cooked"] = {
		label = "Cooked Deer Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_mtlion_meat_cooked"] = {
		label = "Cooked Lion Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_boar_meat_cooked"] = {
		label = "Cooked Boar Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_coyote_meat_cooked"] = {
		label = "Cooked Coyote Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_chickenhawk_meat_cooked"] = {
		label = "Cooked Chickenhawk Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_rabbit_meat_cooked"] = {
		label = "Cooked Rabbit Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_crow_meat_cooked"] = {
		label = "Cooked Crow Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_pigeon_meat_cooked"] = {
		label = "Cooked Pigeon Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	["hunting_seagull_meat_cooked"] = {
		label = "Cooked Seagull Meat",
		weight = 800,
		stack = true,
		close = true,
		usable = true,
		description = "",
	},

	------- electrical-------
	["wires"] = {
		label = "wires",
		weight = 80,
		stack = true,
		close = true,
		usable = false,
		description = "",
	},

	["battery"] = {
		label = "battery",
		weight = 100,
		stack = true,
		close = true,
		usable = false,
		description = "",
	},

	-------gruppesechs tablet
	["gruppesechstablet"] = {
		label = "gruppe sechs tablet",
		weight = 100,
		stack = false,
		close = true,
		usable = true,
		decay = true,
		degrade = 4800,
		description = "Password: 1234 written on the back",
	},

	------ renewed weed ----
	['female_seed'] = {
		label = 'Female Seed',
		weight = 1,
		client = {
			export = 'Renewed-Weed.placeWeed',
			image = 'weed_seed.png'
		}
	},

	['male_seed'] = {
		label = 'Male Seed',
		weight = 1,
		client = {
			image = 'weed_seed.png'
		}
	},

	['wetweed'] = {
		label = 'Wet Bud',
		weight = 0,
	},

	['driedweed'] = {
		label = 'Dry Bud',
		weight = 50,
		buttons = {
			{
				label = 'Make into a brick',
				action = function(slot)
					exports['Renewed-Weed']:makeBrick(slot)
				end
			}
		}
	},

	['dryingrack'] = {
		label = 'Drying Rack',
		weight = 2500,
		consume = 0,
		server = {
			export = 'Renewed-Weed.placeDryingRack'
		}
	},

	['dryingrackadvanced'] = {
		label = 'Advanced Drying Rack',
		weight = 5000,
		consume = 0,
		server = {
			export = 'Renewed-Weed.placeDryingRack'
		}
	},

	['weedbrick'] = {
		label = 'Weed Brick',
		weight = 0,
	},

	['joint'] = {
		label = 'Joint',
		weight = 25,
	},

	['emptybag'] = {
		label = 'Empty Bag',
		weight = 5,
	},

	['fullbag'] = {
		label = 'Bag of Weed',
		description = 'A 3 oz bag of weed',
		weight = 55,
	},

	['wateringcan'] = {
		label = 'Watering Can',
		weight = 0,
	},

	['fertilizer'] = {
		label = 'Fertilizer',
		weight = 1500,
	},

	['scale'] = {
		label = 'scale',
		weight = 1500,
	},

	["weed_nutrition"] = {
		label = "Plant Fertilizer",
		weight = 2000,
		stack = true,
		close = true,
		description = "Plant nutrition",
		client = {
			image = "weed_nutrition.png",
		}
	},

	["oilbarrel"] = {
		label = 'Oil Barrel',
		stack = false,
		weight = 0,
	},

	["driveshaft"] = {
		label = 'Drive Shaft',
		weight = 1000,
		stack = false
	},

	["oilfilter"] = {
		label = 'Oil Filter',
		weight = 1000,
		stack = false
	},

	["reliefstring"] = {
		label = 'Relief String',
		weight = 1000,
		stack = false
	},

	["skewgear"] = {
		label = 'Skew Gear',
		weight = 1000,
		stack = false
	},

	["timingchain"] = {
		label = 'Timing Chain',
		weight = 1000,
		stack = false
	},

	["medikit"] = {
		label = 'Medikit',
		weight = 2500,
		stack = false,
		close = true,
		description = 'You can use this medikit to treat your patients',
		client = {
			image = 'medikit.png',
		}
	},

	["medbag"] = {
		label = 'Medical Bag',
		weight = 2500,
		stack = false,
		close = true,
		description = 'A bag of medic tools',
		client = {
			image = 'medbag.png',
		}
	},

	["tweezers"] = {
		label = 'Tweezers',
		weight = 50,
		stack = true,
		close = true,
		description = 'For picking out bullets',
		client = {
			image = 'tweezers.png',
		}
	},

	["suturekit"] = {
		label = 'Suture Kit',
		weight = 60,
		stack = true,
		close = true,
		description = 'For stitching your patients',
		client = {
			image = 'suturekit.png',
		}
	},

	["icepack"] = {
		label = 'Ice Pack',
		weight = 110,
		stack = true,
		close = true,
		description = 'To help reduce swelling',
		client = {
			image = 'icepack.png',
		}
	},

	["burncream"] = {
		label = 'Burn Cream',
		weight = 125,
		stack = true,
		close = true,
		description = 'To help with burns',
		client = {
			image = 'burncream.png',
		}
	},

	["defib"] = {
		label = 'Defibrillator',
		weight = 1120,
		stack = false,
		close = true,
		description = 'Used to revive patients',
		client = {
			image = 'defib.png',
		}
	},

	["sedative"] = {
		label = 'Sedative',
		weight = 20,
		stack = true,
		close = true,
		description = 'If needed, this will sedate patient',
		client = {
			image = 'sedative.png',
		}
	},

	["morphine30"] = {
		label = 'Morphine 30MG',
		weight = 2,
		stack = true,
		close = true,
		description = 'A controlled substance to control pain',
		client = {
			image = 'morphine30.png',
		}
	},

	["morphine15"] = {
		label = 'Morphine 15MG',
		weight = 2,
		stack = true,
		close = true,
		description = 'A controlled substance to control pain',
		client = {
			image = 'morphine15.png',
		}
	},

	["perc30"] = {
		label = 'Percocet 30MG',
		weight = 2,
		stack = true,
		close = true,
		description = 'A controlled substance to control pain',
		client = {
			image = 'perc30.png',
		}
	},

	["perc10"] = {
		label = 'Percocet 10MG',
		weight = 2,
		stack = true,
		close = true,
		description = 'A controlled substance to control pain',
		client = {
			image = 'perc10.png',
		}
	},

	["perc5"] = {
		label = 'Percocet 5MG',
		weight = 2,
		stack = true,
		close = true,
		description = 'A controlled substance to control pain',
		client = {
			image = 'perc5.png',
		}
	},

	["vic10"] = {
		label = 'Vicodin 10MG',
		weight = 2,
		stack = true,
		close = true,
		description = 'A controlled substance to control pain',
		client = {
			image = 'vic10.png',
		}
	},

	["vic5"] = {
		label = 'Vicodin 5MG',
		weight = 2,
		stack = true,
		close = true,
		description = 'A controlled substance to control pain',
		client = {
			image = 'vic5.png',
		}
	},

	["container_masterKey"] = {
		label = "Dont get caught with this",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A master key to open all containers",
        export = "remix_containers.useMasterKey",
	},
	
	["container1"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container2"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container3"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container4"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container5"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container6"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container7"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container8"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container9"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container10"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container11"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container12"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container13"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container14"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container15"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container16"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container17"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},

	["container18"] = {
		label = "Securo Serv",
		weight = 5,
		stack = false,
		close = true,
		dropModel = "prop_cs_key_01",
		description = "A key to open a container",
		degrade = 43800,
        export = "remix_containers.useContainerKey",
		client = {
			image = 'key_b.png',
		}
	},
	
		-- Kevin Pawnshop Items
	["pawnshop_box"] = {
		label = "Pawnshop Box",
		weight = 2000,
		stack = true,
		close = true,
		description = "A box of pawn shop items",
		client = {
			image = "postal_box.png",
		}
	},

	-- Renewed Farming Items

	['pitchfork'] = {
    label = 'Pitch Fork',
    weight = 1000,
    client = {
        export = 'Renewed-Farming.harvestPlants'
    },
},

 
['beetroot'] = {
    label = 'Beetroot',
    description = 'Freshly harvested beetroot, perfect for cooking or adding to salads.',
    weight = 100
},
['beetrootseed'] = {
    label = 'Beetroot Seed',
    description = 'Small seeds used to grow beetroot plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    },
},
 
['carrot'] = {
    label = 'Carrot',
    description = 'Crisp and nutritious carrots, a staple ingredient in many recipes. Can be enjoyed raw or cooked.',
    weight = 100
},
['carrotseed'] = {
    label = 'Carrot Seed',
    description = 'Tiny seeds used to grow carrot plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 

['cornseed'] = {
    label = 'Corn Seed',
    description = 'Small seeds used to grow corn plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['cucumber'] = {
    label = 'Cucumber',
    description = 'Crisp and refreshing cucumbers, perfect for salads or pickling.',
    weight = 100
},
['cucumberseed'] = {
    label = 'Cucumber Seed',
    description = 'Tiny seeds used to grow cucumber plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['garlic'] = {
    label = 'Garlic',
    description = 'Aromatic garlic bulbs, known for their strong flavor and various culinary uses.',
    weight = 100
},
['garlicseed'] = {
    label = 'Garlic Seed',
    description = 'Small cloves used to grow garlic plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['potato'] = {
    label = 'Potato',
    description = 'Versatile and starchy potatoes, ideal for mashing, baking, or frying.',
    weight = 100,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['pumpkin'] = {
    label = 'Pumpkin',
    description = 'Large and festive pumpkins, perfect for carving or using in autumn recipes.',
    weight = 100,
},
['pumpkinseed'] = {
    label = 'Pumpkin Seed',
    description = 'Seeds used to grow pumpkin plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['radish'] = {
    label = 'Radish',
    description = 'Crunchy and peppery radishes, great for adding a kick to salads or pickling.',
    weight = 100
},
['radishseed'] = {
    label = 'Radish Seed',
    description = 'Small seeds used to grow radish plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['sunflower'] = {
    label = 'Sunflower',
    description = 'Bright and cheerful sunflowers, known for their tall stalks and vibrant yellow petals.',
    weight = 100
},
['sunflowerseed'] = {
    label = 'Sunflower Seed',
    description = 'Seeds used to grow sunflower plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 

['tomatoseed'] = {
    label = 'Tomato Seed',
    description = 'Small seeds used to grow tomato plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['watermelon'] = {
    label = 'Watermelon',
    description = 'Large and refreshing watermelons, perfect for summertime enjoyment.',
    weight = 100
},
['watermelonseed'] = {
    label = 'Watermelon Seed',
    description = 'Seeds used to grow watermelon plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['cabbage'] = {
    label = 'Cabbage',
    description = 'Fresh and crisp cabbage, perfect for salads and cooking.',
    weight = 100
},
['cabbageseed'] = {
    label = 'Cabbage Seed',
    description = 'Seeds used to grow cabbage plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['onion'] = {
    label = 'Onion',
    description = 'Pungent and flavorful onions, a kitchen essential.',
    weight = 100
},
['onionseed'] = {
    label = 'Onion Seed',
    description = 'Seeds used to grow onion plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['wheat'] = {
    label = 'Wheat',
    description = 'Golden wheat grains, a staple crop used for making flour and various food products.',
    weight = 100
},
['wheatseed'] = {
    label = 'Wheat Seed',
    description = 'Small seeds used to grow wheat plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['barley'] = {
    label = 'Barley',
    description = 'Barley grains, a staple crop used for making various food products.',
    weight = 50
},
['barleyseed'] = {
    label = 'Barley Seed',
    description = 'Small seeds used to grow barley plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},
 
['sugarbeet'] = {
    label = 'Sugarbeet',
    description = 'Freshly harvested sugar beets, perfect for cooking.',
    weight = 50
},
['sugarbeetseed'] = {
    label = 'Sugarbeet Seed',
    description = 'Small seeds used to grow sugarbeet plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},

['riceseed'] = {
    label = 'Rice Seed',
    description = 'Small seeds used to grow rice plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},

['pepperseed'] = {
    label = 'Pepper Seed',
    description = 'Small seeds used to grow pepper plants.',
    weight = 10,
    client = {
        export = 'Renewed-Farming.placeSeed'
    }
},

-- ## Sanitation ##--
["garbage_bag"] = {
	label = "Garbage Bag",
	weight = 400,
	stack = false,
	close = true,
},

------ electrical job (pickles)
['electrician_ladder'] = {
    label = 'Electrician Ladder',
    weight = 1,
    stack = false,
    description = ""
},

['electrician_lift'] = {
    label = 'Electrician Lift',
    weight = 1,
    stack = false,
    description = ""
},

['electrician_rail'] = {
    label = 'Electrician Rail',
    weight = 1,
    stack = false,
    description = ""
},

----- pickles arcade

['arcade_pigeonascent'] = {
    label = 'Arcade (Pigeon Ascent)',
    weight = 1,
    stack = true,
    description = ""
},
['arcade_tinycrate'] = {
    label = 'Arcade (Tiny Crate)',
    weight = 1,
    stack = true,
    description = ""
},
['arcade_littlespy'] = {
    label = 'Arcade (Little Spy)',
    weight = 1,
    stack = true,
    description = ""
},

----- MT WORKSHOP

["engine_s"] = {
	label = "Engine S",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["engine_a"] = {
	label = "Engine A",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["engine_b"] = {
	label = "Engine B",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["engine_c"] = {
	label = "Engine C",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["engine_d"] = {
	label = "Engine D",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["transmission_s"] = {
	label = "Transmission S",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["transmission_a"] = {
	label = "Transmission A",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["transmission_b"] = {
	label = "Transmission B",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["transmission_c"] = {
	label = "Transmission C",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["transmission_d"] = {
	label = "Transmission D",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["suspension_s"] = {
	label = "Suspension S",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["suspension_a"] = {
	label = "Suspension A",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["suspension_b"] = {
	label = "Suspension B",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["suspension_c"] = {
	label = "Suspension C",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["suspension_d"] = {
	label = "Suspension D",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["brake_s"] = {
	label = "Brake S",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["brake_a"] = {
	label = "Brake A",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["brake_b"] = {
	label = "Brake B",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["brake_c"] = {
	label = "Brake C",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["brake_d"] = {
	label = "Brake D",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["turbo_s"] = {
	label = "Turbo S",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["turbo_a"] = {
	label = "Turbo A",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["turbo_b"] = {
	label = "Turbo B",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["turbo_c"] = {
	label = "Turbo C",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["turbo_d"] = {
	label = "Turbo D",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["armour_s"] = {
	label = "Armour S",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["armour_a"] = {
	label = "Armour A",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["armour_b"] = {
	label = "Armour B",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["armour_c"] = {
	label = "Armour C",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["armour_d"] = {
	label = "Armour D",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["engine_repair_kit"] = {
	label = "Engine repair kit",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["body_repair_kit"] = {
	label = "Body repair kit",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["cosmetics"] = {
	label = "Cosmetics",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
},
["mechanic_toolbox"] = {
	label = "Mechanics toolbox",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
	client = {
		export = 'mt_workshops.openToolboxMenu'
	}
},
["neons_controller"] = {
	label = "Neons controller",
	weight = 1000,
	stack = true,
	close = true,
	description = "",
	client = {
		export = 'mt_workshops.openLightsController'
	}
},
["mods_list"] = {
	label = "Vehicle mods list",
	weight = 0,
	stack = true,
	close = true,
	description = "",
	client = {
		export = 'mt_workshops.openCosmeticsMenu'
	}
},
["extras_controller"] = {
	label = "Vehicle extras",
	weight = 0,
	stack = true,
	close = true,
	description = "",
	client = {
		export = 'mt_workshops.openExtrasMenu'
	}
},

----MT RESTURANTS
["restaurant_food"] = {
    label = "Restaurant food",
    weight = 0,
    stack = true,
    close = true,
    client = {
        export = 'mt-restaurants.useFoodItem'
    }
},
["restaurant_box"] = {
    label = "Restaurant box",
    weight = 0,
    stack = true,
    close = true,
    client = {
        export = 'mt-restaurants.useBoxItem'
    }
},
["restaurant_menu"] = {
    label = "Restaurant menu",
    weight = 0,
    stack = true,
    close = true,
    client = {
        export = 'mt-restaurants.openMenu'
    }
},
['meat'] = {
    label = 'Meat',
    weight = 8,
    stack = true,
    close = true,
	decay = true,
	degrade = 4800,
    description = '',
},

['coffee_beans'] = {
    label = 'Coffee Beans',
    weight = 8,
    stack = true,
    close = true,
    description = '',
},

['soya'] = {
    label = 'Soya',
    weight = 8,
    stack = true,
    close = true,
    description = '',
},

 
['apple'] = {
    label = 'Apple',
    weight = 12,
    stack = true,
    close = true,
    description = '',
},
['pear'] = {
    label = 'Pear',
    weight = 12,
    stack = true,
    close = true,
    description = '',
},
['lemon'] = {
    label = 'Lemon',
    weight = 12,
    stack = true,
    close = true,
    description = '',
},	
['peach'] = {
    label = 'Peach',
    weight = 13,
    stack = true,
    close = true,
    description = '',
},
['mango'] = {
    label = 'Mango',
    weight = 13,
    stack = true,
    close = true,
    description = '',
},
 
['cutted_meat'] = {
    label = 'Cutted meat',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_fish'] = {
    label = 'Cutted fish',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_onion'] = {
    label = 'Cutted onion',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_carrot'] = {
    label = 'Cutted carrot',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_lettuce'] = {
    label = 'Cutted lettuce',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_cucumber'] = {
    label = 'Cutted cucumber',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_potato'] = {
    label = 'Cutted potato',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_tomato'] = {
    label = 'Cutted tomato',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_coffee'] = {
    label = 'Coffee powder',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_wheat'] = {
    label = 'Flour',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_corn'] = {
    label = 'Corn flour',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_strawberry'] = {
    label = 'Cutted strawberry',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_watermelon'] = {
    label = 'Cutted watermelon',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_soya'] = {
    label = 'Cutted tofu',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_pineapple'] = {
    label = 'Cutted pineapple',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_apple'] = {
    label = 'Cutted apple',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_pear'] = {
    label = 'Cutted pear',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_lemon'] = {
    label = 'Cutted lemon',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_banana'] = {
    label = 'Cutted banana',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_peach'] = {
    label = 'Cutted peach',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_mango'] = {
    label = 'Cutted mango',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},
['cutted_orange'] = {
    label = 'Cutted orange',
    weight = 20,
    stack = true,
    close = true,
    description = '',
},

---- pickles lottery
['lottery_keno'] = {
    label = 'Keno Ticket',
    weight = 1,
    stack = true,
    description = ""
},
['lottery_moneyball'] = {
    label = 'Moneyball Ticket',
    weight = 1,
    stack = true,
    description = ""
},
['lottery_pickle'] = {
    label = 'Pickle Scratch-off',
    weight = 1,
    stack = false,
    description = ""
},
['lottery_wildcherry'] = {
    label = 'Wild Cherry Scratch-off',
    weight = 1,
    stack = false,
    description = ""
},
['lottery_luckyseven'] = {
    label = 'Lucky 7\'s Scratch-off',
    weight = 1,
    stack = false,
    description = ""
},
['lottery_receipt'] = {
    label = 'Lottery Receipt',
    weight = 1,
    stack = false,
    description = ""
},

------ pickle construction

['lift'] = {
    label = 'Lift',
    weight = 1,
    stack = true,
    description = ""
},

['lift_rail'] = {
    label = 'Lift Rail',
    weight = 1,
    stack = true,
    description = ""
},

['planks'] = {
    label = 'Wooden Planks',
    weight = 1,
    stack = true,
    description = ""
},

['nail'] = {
    label = 'Nail',
    weight = 1,
    stack = true,
    description = ""
},

----pickle businesses

-- Businesses Items

["food_trailer_1"] = {
    label = 'food trailer 1',
    weight = 1,
    stack = true,
    description = ""
},
["food_trailer_2"] = {
    label = 'food trailer 2',
    weight = 1,
    stack = true,
    description = ""
},
["syrup_mix"] = {
    label = 'syrup mix',
    weight = 1,
    stack = true,
    description = ""
},
["carbonated_water"] = {
    label = 'carbonated water',
    weight = 1,
    stack = true,
    description = ""
},
["burger_bun"] = {
    label = 'burger bun',
    weight = 1,
    stack = true,
    description = ""
},
["hotdog_bun"] = {
    label = ' hotdog bun',
    weight = 1,
    stack = true,
    description = ""
},
["burger_patty"] = {
    label = 'burger patty',
    weight = 1,
    stack = true,
    description = ""
},
["sausage"] = {
    label = 'sausage',
    weight = 1,
    stack = true,
    description = ""
},
["special_seasoning"] = {
    label = 'special seasoning',
    weight = 1,
    stack = true,
    description = ""
},
["fries"] = {
    label = 'Fries',
    weight = 1,
    stack = true,
    description = ""
},
['laptop'] = {
	label = 'Facade Laptop',
	description = 'A high-tech gadget that is always up to something',
	stack = false,
	close = false,
	consume = 0,
	client = {
		image = 'fd_laptop.png',
	},
	server = {
		export = 'fd_laptop.useLaptop'
	},
	buttons = {
		{
			label = "Open storage",
			action = function(slot)
				TriggerServerEvent("fd_laptop:server:openLaptopStorage", slot)
			end
		}
	}
},

	    -- Kevin Recylers Items
    ["recycler"] = {
        label = "Recycler",
        weight = 10000,
        stack = true,
        close = true,
        description = "A machine to recycle items",
    },
    ['empty_recycleables_crate'] = {
        label = "Empty Recycleables Crate",
        weight = 100,
        stack = true,
        close = true,
        description = "An empty crate for recycleables",
    },
    ["recycleables"] = {
        label = "Recycleables",
        weight = 10000,
        stack = true,
        close = true,
        description = "Items to recycle",
    },

------Pickle Firefighter
['watertank'] = {
    label = 'Water Tank',
    weight = 1,
    stack = true,
    close = true,
    description = nil
},

['auto_parts'] = {
    label = 'Auto Parts',
    weight = 5,
},

['chop_lockpick'] = {
    label = 'Car Tool',
    weight = 150,
},

['chop_torch'] = {
    label = 'Torch',
    weight = 275,
},

['chop_lugwrench'] = {
    label = 'Lug Wrench',
    weight = 225,
},

["coffeemaker"] = {
	label = "Coffee Maker",
	weight = 500,
	stack = true,
	close = false,
	description = "To make that perfect cup of Joe!",
	client = {
	  image = "coffeemaker.png"
	}
   },
  
   ["x_artpiece"] = {
	label = "Art Piece",
	weight = 500,
	stack = true,
	close = false,
	description = "A unique piece of art!",
	client = {
	  image = "x_artpiece.png"
	}
   },
  
   ["x_guitar"] = {
	label = "Guitar",
	weight = 300,
	stack = true,
	close = false,
	description = "A guitar!",
	client = {
	  image = "x_guitar.png"
	}
   },
  
   ["microwave"] = {
	label = "Microwave",
	weight = 800,
	stack = true,
	close = false,
	description = "A microwave - for heating things up!",
	client = {
	  image = "microwave.png"
	}
   },
  
   ["x_painting"] = {
	label = "Painting",
	weight = 200,
	stack = true,
	close = false,
	description = "A modern work of art!",
	client = {
	  image = "x_painting.png"
	}
   },
  
   ["x_painting2"] = {
	label = "Painting",
	weight = 200,
	stack = true,
	close = false,
	description = "A modern work of art!",
	client = {
	  image = "x_painting2.png"
	}
   },
  
   ["x_pcequipment"] = {
	label = "PC",
	weight = 600,
	stack = true,
	close = false,
	description = "A PC, for gaming?! Well of course it is!",
	client = {
	  image = "x_pcequipment.png"
	}
   },
  
   ["x_suitcase"] = {
	label = "Suit Case",
	weight = 200,
	stack = true,
	close = false,
	description = "A leather suitcase, what the hell is inside of this?",
	client = {
	  image = "x_suitcase.png"
	}
   },
  
   ["x_television"] = {
	label = "Television",
	weight = 800,
	stack = true,
	close = false,
	description = "A modern flatscreen TV",
	client = {
	  image = "x_television.png"
	}
   },

	---- lation chop


-----SD OXY

["bands"] = {
    label = "Band Of Notes",
    weight = 100,
    stack = true,
    close = false,
    description = "A band of small notes..",
    consume = 0,
    client = {
        image = "bands.png",
    }
},

["rolls"] = {
    label = "Roll Of Small Notes",
    weight = 100,
    stack = true,
    close = false,
    description = "A roll of small notes..",
    consume = 0,
    client = {
        image = "rolls.png",
    }
},

["package"] = {
    label = "Suspicious Package",
    weight = 10000,
    stack = false,
    close = false,
    description = "A mysterious package.. Scary!",
    consume = 0,
    client = {
        image = "package.png",
    }
},
["oxy"] = {
    label = "Prescription Oxy",
    weight = 0,
    stack = true,
    close = true,
    description = "The Label Has Been Ripped Off",
    consume = 0,
    client = {
        image = "oxy.png",
    },
},

	------ moonshine
	['bucket_empty'] = {
		label = 'Empty bucket',
		weight = 10,
		stack = false,
		close = true,
		description = 'Just a empty bucket.'
	},
	['bucket_full'] = {
		label = 'full bucket',
		weight = 100,
		stack = false,
		close = true,
		description = 'Just a bucket full of water.'
	},
	['bucket_mash'] = {
		label = 'full mash bucket',
		weight = 100,
		stack = false,
		close = true,
		description = 'Just a bucket full of mash.'
	},
	['jar_empty'] = {
		label = 'Empty jar',
		weight = 10,
		stack = true,
		close = true,
		description = 'Just a empty jar.'
	},
	['jar_shine'] = {
		label = 'Jar of moonshine',
		weight = 15,
		stack = true,
		close = true,
		description = 'Moonshine.'
	},
	['shine_crate_empty'] = {
		label = 'Empty crate',
		weight = 10,
		stack = false,
		close = true,
		description = 'used for storing Moonshine.',
	},
	['shine_crate'] = {
		label = 'Moonshine crate',
		weight = 1000,
		stack = false,
		close = true,
		description = 'Full crate of moonshine.',
	},
	['trowel'] = {
		label = 'Trowel',
		weight = 20,
		stack = false,
		close = true,
		description = 'A trowel.',
	},

	---- atm robbery
	["small_bands"] = {
		label = "Bounty Contract",
		weight = 0,
		stack = false,
		close = true,
		description = "Small Bands",
		client = {
			image = "small_bands.png",
		}
	},

	-----project x ATM
	['nylonrope'] = {
        label = 'Nylon Rope',
        description = 'The strongest rope material..',
        weight = 125,
        close = true,
        stack = true,
        client = {
      image = "nylonrope.png",
   event = 'projectx-atmrobbery:client:UseRope',
    }
    },

    ['atmred'] = {
        label = 'Red ATM',
        description = 'A console of an automated teller.',
        weight = 350,
        close = true,
        stack = false,
        client = {
      image = "atmred.png",
   event = 'projectx-atmrobbery:client:UseAtm-Red',
    }
    },

    ['atmblue'] = {
        label = 'Blue ATM',
        description = 'A console of an automated teller.',
        weight = 350,
        close = true,
        stack = false,
        client = {
      image = "atmblue.png",
   event = 'projectx-atmrobbery:client:UseAtm-Blue',
    }
    },

    ['atmgreen'] = {
        label = 'Green ATM',
        description = 'A console of an automated teller.',
        weight = 350,
        close = true,
        stack = false,
        client = {
      image = "atmgreen.png",
   event = 'projectx-atmrobbery:client:UseAtm-Green',
    }
    },

    ['atmpanel'] = {
        label = 'ATM Panel',
        description = 'A back panel from an automated teller.',
        weight = 125,
        close = true,
        stack = false,
        client = {
      image = "atmpanel.png",
    }
    },

    ['atmcables'] = {
        label = 'ATM Cables',
        description = 'Cables from an automated teller.',
        weight = 125,
        close = true,
        stack = false,
        client = {
      image = "atmcables.png",
    }
    },

    ['atmmotherboard'] = {
        label = 'ATM Motherboard',
        description = 'A motherboard from an automated teller.',
        weight = 125,
        close = true,
        stack = false,
        client = {
      image = "atmmotherboard.png",
    }
    },

    ['blowtorch'] = {
        label = 'Blow Torch',
        description = 'Ooo hot...',
        weight = 125,
        close = true,
        stack = false,
        client = {
      image = "blowtorch.png",
    }
    },

    ['laserdrill'] = {
        label = 'Laser Drill',
        description = 'I wonder what this does...',
        weight = 125,
        close = true,
        stack = false,
        client = {
      image = "laserdrill.png",
    }
    },

    ["x_gastank"] = {
      label = "X Gas Tank",
      weight = 200,
      stack = true,
      close = false,
      description = "????",
      client = {
        image = "x_gastank.png",
      }
    },

    ["x_fakecredit"] = {
      label = "X Credit Card",
      weight = 200,
      stack = true,
      close = false,
      description = "????",
      client = {
        image = "x_fakecredit.png",
      }
    },
	["x_device"] = {
		label = "Digital Device",
		weight = 200,
		stack = true,
		close = false,
		description = "????",
		client = {
		  image = "x_device.png",
		}
	  },

    ["flight_artpiece"] = {
        label = "Art",
        weight = 25000,
        stack = false,
        close = true,
        description = "Some fancy Art",
        client = {
            image = "flightartpiece.png",
        }
    },

    ["flight_painting2"] = {
        label = "Painting",
        weight = 25000,
        stack = false,
        close = true,
        description = "Just a work of art,",
        client = {
            image = "flightpainting2.png",
        }
    },

    ["flight_painting"] = {
        label = "Painting",
        weight = 25000,
        stack = false,
        close = true,
        description = "Just a work of art,",
        client = {
            image = "flightpainting.png",
        }
    },

    ["flight_suitcase"] = {
        label = "Suitcase",
        weight = 25000,
        stack = false,
        close = true,
        description = "Work Suitcase",
        client = {
            image = "flightsuitcase.png",
        }
    },

    ["flight_television"] = {
        label = "TV",
        weight = 25000,
        stack = false,
        close = true,
        description = "Flat Screen TV",
        client = {
            image = "flighttelevision.png",
        }
    },

    ["pcequipment"] = {
        label = "Computer Equipment",
        weight = 25000,
        stack = false,
        close = true,
        description = "Computer Equipment",
        client = {
            image = "flightpcequipment.png",
        }
    },

    ["flight_guitar"] = {
        label = "Guitar",
        weight = 25000,
        stack = false,
        close = true,
        description = "Music Equipment",
        client = {
            image = "flightguitar.png",
        }
    },

    ["hacking-laptop"] = {
        label = "Hacking Laptop",
        weight = 1500,
        stack = false,
        close = true,
		decay = true,
		degrade = 4800,
        description = "",
        client = {
            image = "hacking-laptop.png",
        }
    },

    ["gps-device"] = {
        label = "Gps Device",
        weight = 1500,
        stack = false,
        close = true,
        description = "",
        client = {
            image = "gps-device.png",
        }
    },

    ["kthermite"] = {
        label = "Thermite",
        weight = 500,
        stack = false,
        close = true,
        description = "",
        client = {
            image = "thermite.png",
        }
    },


	-----sd bobcat

	["bobcatkeycard"] = {
		label = "Bobcat Security Card",
		weight = 1000,
		stack = false,
		close = true,
		description = "A keycard used at the Bobcat Security Deposit.",
		consume = 0,
		client = {
			image = "bobcatkeycard.png",
		}
	},
	
	["c4_bomb"] = {
		label = "C4 Brick",
		weight = 1000,
		stack = false,
		close = true,
		description = "Very Dangerous! High Yield Explosive.",
		consume = 0,
		client = {
			image = "c4_bomb.png",
		}
	},
	
	["thermite_h"] = {
		label = "Thermite",
		weight = 1000,
		stack = false,
		close = true,
		description = "A low-yield thermite charge.",
		consume = 0,
		client = {
			image = "thermite_h.png",
		},
		server = {
			export = 'sd-bobcat.useThermite_h',
		}
	},
	
		----- lation mining

		["ls_pickaxe"] = {
			label = 'Pickaxe',
			weight = 100,
			stack = false,
		},
		
		["ls_copper_pickaxe"] = {
			label = 'Copper Pickaxe',
			weight = 100,
			stack = false,
		},
		
		["ls_iron_pickaxe"] = {
			label = 'Iron Pickaxe',
			weight = 100,
			stack = false,
		},
		
		["ls_silver_pickaxe"] = {
			label = 'Silver Pickaxe',
			weight = 100,
			stack = false,
		},
		
		["ls_gold_pickaxe"] = {
			label = 'Gold Pickaxe',
			weight = 100,
			stack = false,
		},
		
		["ls_copper_ore"] = {
			label = 'Copper Ore',
			weight = 100,
			stack = true,
		},
		
		["ls_coal_ore"] = {
			label = 'Coal Ore',
			weight = 100,
			stack = true,
		},
		
		["ls_iron_ore"] = {
			label = 'Iron Ore',
			weight = 100,
			stack = true,
		},
		
		["ls_silver_ore"] = {
			label = 'Silver Ore',
			weight = 100,
			stack = true,
		},
		
		["ls_gold_ore"] = {
			label = 'Gold Ore',
			weight = 100,
			stack = true,
		},
		
		["ls_copper_ingot"] = {
			label = 'Copper Ingot',
			weight = 500,
			stack = true,
		},
		
		["ls_iron_ingot"] = {
			label = 'Iron Ingot',
			weight = 500,
			stack = true,
		},
		
		["ls_silver_ingot"] = {
			label = 'Silver Ingot',
			weight = 500,
			stack = true,
		},
		
		["ls_gold_ingot"] = {
			label = 'Gold Ingot',
			weight = 500,
			stack = true,
		},

		["liquidiron"] = {
			label = 'Liquid Iron',
			weight = 500,
			stack = true,
		},

		["wallet"] = {
			label = 'Wallet',
			weight = 50,
			stack = false,
		},

		["purse"] = {
			label = 'Purse',
			weight = 50,
			stack = false,
		},

		["mouldingkit"] = {
			label = 'Moulding Kit',
			weight = 500,
			stack = false,
		},
-- ### items for zat farming ## --
["farm_seed_carrot"] = {
		label = "Carrot Seed",
		weight = 100,
		stack = false,
		close = true,
		description = "Carrot Seed",
		client = {
			image = "farm_seed.png",
		}
	},

	["farm_carrot_mash"] = {
		label = "Mash Carrot",
		weight = 100,
		stack = false,
		close = true,
		description = "Mash Carrot",
		client = {
			image = "farm_carrot_mash.png",
		}
	},

	["farm_sink_s"] = {
		label = "Sink",
		weight = 100,
		stack = false,
		close = true,
		description = "Sink",
		client = {
			image = "farm_sink_s.png",
		}
	},

	["farm_light_s"] = {
		label = "Light S",
		weight = 100,
		stack = false,
		close = true,
		description = "Light S",
		client = {
			image = "farm_light_s.png",
		}
	},

	["farm_carrot_comp"] = {
		label = "Rotten Carrot",
		weight = 100,
		stack = false,
		close = true,
		description = "Rotten Carrot",
		client = {
			image = "farm_carrot_comp.png",
		}
	},

	["farm_sink_m"] = {
		label = "Modern Sink",
		weight = 100,
		stack = false,
		close = true,
		description = "Modern Sink",
		client = {
			image = "farm_sink_m.png",
		}
	},

	["moon_distillation"] = {
		label = "Distillation",
		weight = 100,
		stack = false,
		close = true,
		description = "Moonshine Distillation",
		client = {
			image = "moon_distillation.png",
		}
	},

	["farm_onion_comp"] = {
		label = "Rotten Onion",
		weight = 100,
		stack = false,
		close = true,
		description = "Rotten Onion",
		client = {
			image = "farm_onion_comp.png",
		}
	},

	["farm_corn_mash"] = {
		label = "Mash Corn",
		weight = 100,
		stack = false,
		close = true,
		description = "Mash Corn",
		client = {
			image = "farm_corn_mash.png",
		}
	},

	["farm_light_l"] = {
		label = "Light L",
		weight = 100,
		stack = false,
		close = true,
		description = "Light L",
		client = {
			image = "farm_light_l.png",
		}
	},

	["farm_seed_sunflower"] = {
		label = "SunFlower Seed",
		weight = 100,
		stack = false,
		close = true,
		description = "SunFlower Seed",
		client = {
			image = "farm_seed.png",
		}
	},

	["moon_moonshine_pack"] = {
		label = "Moonshine Pack",
		weight = 100,
		stack = false,
		close = true,
		description = "Moonshine Pack",
		client = {
			image = "moon_moonshine_pack.png",
		}
	},

	["farm_seed_wheat"] = {
		label = "Wheat Seed",
		weight = 100,
		stack = false,
		close = true,
		description = "Wheat Seed",
		client = {
			image = "farm_seed.png",
		}
	},

	["farm_sunflower_comp"] = {
		label = "Rotten SunFlower",
		weight = 100,
		stack = false,
		close = true,
		description = "Rotten SunFlower",
		client = {
			image = "farm_sunflower_comp.png",
		}
	},

	["farm_tomato_comp"] = {
		label = "Rotten Tomato",
		weight = 100,
		stack = false,
		close = true,
		description = "Rotten Tomato",
		client = {
			image = "farm_tomato_comp.png",
		}
	},

	["farm_mil"] = {
		label = "Mil Machine",
		weight = 100,
		stack = false,
		close = true,
		description = "Mil Machine",
		client = {
			image = "farm_mil.png",
		}
	},

	["farm_seed_tomato"] = {
		label = "Tomato Seed",
		weight = 100,
		stack = false,
		close = true,
		description = "Tomato Seed",
		client = {
			image = "farm_seed.png",
		}
	},

	["farm_pot_xs"] = {
		label = "Pot XS",
		weight = 100,
		stack = false,
		close = true,
		description = "XS Pot",
		client = {
			image = "farm_pot_xs.png",
		}
	},

	["farm_pot_m"] = {
		label = "Pot M",
		weight = 100,
		stack = false,
		close = true,
		description = "M Pot",
		client = {
			image = "farm_pot_m.png",
		}
	},

	["farm_onion"] = {
		label = "Onion",
		weight = 100,
		stack = false,
		close = true,
		description = "Onion",
		client = {
			image = "farm_onion.png",
		}
	},

	["farm_onion_mash"] = {
		label = "Mash Onion",
		weight = 100,
		stack = false,
		close = true,
		description = "Mash Onion",
		client = {
			image = "farm_onion_mash.png",
		}
	},

	["farm_compost"] = {
		label = "Compost Box",
		weight = 100,
		stack = false,
		close = true,
		description = "Compost Box",
		client = {
			image = "farm_compost.png",
		}
	},

	["farm_water_tap"] = {
		label = "Water Tap",
		weight = 100,
		stack = false,
		close = true,
		description = "Water Tap",
		client = {
			image = "farm_water_tap.png",
		}
	},

	["farm_corn"] = {
		label = "Corn",
		weight = 100,
		stack = false,
		close = true,
		description = "Corn",
		client = {
			image = "farm_corn.png",
		}
	},

	["farm_tomato_mash"] = {
		label = "Mash Tomato",
		weight = 100,
		stack = false,
		close = true,
		description = "Mash Tomato",
		client = {
			image = "farm_tomato_mash.png",
		}
	},

	["moon_moonshine"] = {
		label = "Moonshine",
		weight = 100,
		stack = false,
		close = true,
		description = "Moonshine",
		client = {
			image = "moon_moonshine.png",
		}
	},

	["farm_seed_corn"] = {
		label = "Corn Seed",
		weight = 100,
		stack = false,
		close = true,
		description = "Corn Seed",
		client = {
			image = "farm_seed.png",
		}
	},

	["farm_pot_s"] = {
		label = "Pot S",
		weight = 100,
		stack = false,
		close = true,
		description = "S Pot",
		client = {
			image = "farm_pot_s.png",
		}
	},

	["farm_fertilizer"] = {
		label = "Fertilizer",
		weight = 100,
		stack = false,
		close = true,
		description = "Fertilizer",
		client = {
			image = "farm_fertilizer.png",
		}
	},

	["farm_wheat"] = {
		label = "Wheat",
		weight = 100,
		stack = false,
		close = true,
		description = "Wheat",
		client = {
			image = "farm_wheat.png",
		}
	},

	["farm_seed_onion"] = {
		label = "Onion Seed",
		weight = 100,
		stack = false,
		close = true,
		description = "Onion Seed",
		client = {
			image = "farm_seed.png",
		}
	},

	["farm_pot_l"] = {
		label = "Pot L",
		weight = 100,
		stack = false,
		close = true,
		description = "L Pot",
		client = {
			image = "farm_pot_l.png",
		}
	},

	["farm_sunflower_mash"] = {
		label = "Mash SunFlower",
		weight = 100,
		stack = false,
		close = true,
		description = "Mash SunFlower",
		client = {
			image = "farm_sunflower_mash.png",
		}
	},

	["farm_tomato"] = {
		label = "Tomato",
		weight = 100,
		stack = false,
		close = true,
		description = "Tomato",
		client = {
			image = "farm_tomato.png",
		}
	},

	["farm_wheat_mash"] = {
		label = "Mash Wheat",
		weight = 100,
		stack = false,
		close = true,
		description = "Mash Wheat",
		client = {
			image = "farm_wheat_mash.png",
		}
	},

	["farm_water"] = {
		label = "Water Can",
		weight = 100,
		stack = false,
		close = true,
		description = "Water Can",
		client = {
			image = "farm_water.png",
		}
	},

	["farm_yeast"] = {
		label = "Yeast",
		weight = 100,
		stack = false,
		close = true,
		description = "Yeast",
		client = {
			image = "farm_yeast.png",
		}
	},

	["farm_wheat_comp"] = {
		label = "Rotten Wheat",
		weight = 100,
		stack = false,
		close = true,
		description = "Rotten Wheat",
		client = {
			image = "farm_wheat_comp.png",
		}
	},

	["farm_sunflower"] = {
		label = "SunFlower",
		weight = 100,
		stack = false,
		close = true,
		description = "SunFlower",
		client = {
			image = "farm_sunflower.png",
		}
	},

	["farm_carrot"] = {
		label = "Carrot",
		weight = 100,
		stack = false,
		close = true,
		description = "Carrot",
		client = {
			image = "farm_carrot.png",
		}
	},

	["farm_corn_comp"] = {
		label = "Rotten Corn",
		weight = 100,
		stack = false,
		close = true,
		description = "Rotten Corn",
		client = {
			image = "farm_corn_comp.png",
		}
	},

	-- ## added for zat weed ## --
	["zatresfan"] = {
	label = "Modern Fan",
	weight = 100,
	stack = false,
	close = true,
	description = "Fan - 60 and 120 RPM...",
	client = {
		image = "zatresfan.png",
	}
},
["zatrollingpaper"] = {
	label = "Rolling Paper",
	weight = 2000,
	stack = true,
	close = true,
	description = "Rolling paper",
	client = {
		image = "zatrollingpaper.png",
	}
},

["zatpackedweed"] = {
	label = "Packed Weed",
	weight = 100,
	stack = false,
	close = true,
	description = "Weed ready for sale",
	client = {
		image = "zatpackedweed.png",
	}
},

["zatpatioheater"] = {
	label = "Patio Heater",
	weight = 100,
	stack = false,
	close = true,
	description = "Patio heater - LOH 21°C...",
	client = {
		image = "zatpatioheater.png",
	}
},

["zatweedbranch"] = {
	label = "Weed Branch",
	weight = 10000,
	stack = false,
	close = true,
	client = {
		image = "zatweedbranch.png",
	},
	description = "Weed plant",
},
["zatceilinglight"] = {
	label = "Ceiling Light",
	weight = 100,
	stack = false,
	close = true,
	description = "ceiling light...",
	client = {
		image = "zatceilinglight.png",
	}
},

["zatbluelight"] = {
	label = "Blue Light",
	weight = 100,
	stack = false,
	close = true,
	description = "Blue Wall Light - Perfect for plant growth...",
	client = {
		image = "zatbluelight.png",
	}
},
["zatwalllight"] = {
	label = "Wall Light",
	weight = 100,
	stack = false,
	close = true,
	description = "Wall Light...",
	client = {
		image = "zatwalllight.png",
	}
},

["zatweedseed"] = {
	label = "Weed Seed",
	weight = 0,
	stack = false,
	close = true,
	description = "Weed Seed",
	client = {
		image = "zatweedseed.png",
	}
},

["zatweedtable"] = {
	label = "Table",
	weight = 0,
	stack = true,
	close = true,
	description = "Table with Full weed Setup",
	client = {
		image = "zatweedtable.png",
	}
},

["zatweedracks"] = {
	label = "Medium Drying Rack",
	weight = 100,
	stack = true,
	close = true,
	description = "Weed Rack with max 5 slots...",
	client = {
		image = "zatweedracks.png",
	}
},
["zatplanter"] = {
	label = "Planter",
	weight = 100,
	stack = true,
	close = true,
	description = "Home made Garden...",
	client = {
		image = "zatplanter.png",
	}
},

["zatwaterbottlefull"] = {
	label = "Water Bottle Full",
	weight = 100,
	stack = true,
	close = true,
	description = "Water Bottle...",
	client = {
		image = "zatwaterbottlefull.png",
	}
},

["zatwatersetup"] = {
	label = "Water Filtration",
	weight = 100,
	stack = true,
	close = true,
	description = "Water Filtration Setup...",
	client = {
		image = "zatwatersetup.png",
	}
},
["zatfan01"] = {
	label = "Fan",
	weight = 100,
	stack = false,
	close = true,
	description = "Fan - 20 and 50 RPM...",
	client = {
		image = "zatfan01.png",
	}
},

["zatweedrackxs"] = {
	label = "Small Drying Rack",
	weight = 100,
	stack = true,
	close = true,
	description = "Weed Rack with max 3 slots...",
	client = {
		image = "zatweedrackxs.png",
	}
},
["zatweednutrition"] = {
	label = "Plant Fertilizer",
	weight = 2000,
	stack = true,
	close = true,
	description = "Plant nutrition",
	client = {
		image = "zatweednutrition.png",
	}
},
["zatheater"] = {
	label = "Wall Heater",
	weight = 100,
	stack = false,
	close = true,
	description = "Electrical wall heater - LOH 10°C...",
	client = {
		image = "zatheater.png",
	}
},

["zatwallfan"] = {
	label = "Wall Fan",
	weight = 100,
	stack = false,
	close = true,
	description = "Fan - 80 and 200 RPM...",
	client = {
		image = "zatwallfan.png",
	}
},
["zatjoint"] = {
	label = "Joint",
	weight = 0,
	stack = false,
	close = true,
	description = "Sidney would be very proud at you",
	client = {
		image = "zatjoint.png",
	}
},

["zatwaterbottleempty"] = {
	label = "Water Bottle Empty",
	weight = 100,
	stack = true,
	close = true,
	description = "Water Bottle...",
	client = {
		image = "zatwaterbottleempty.png",
	}
},



    ["musicequipment"] = {
        label = "Music Equipment",
        weight = 25000,
        stack = false,
        close = true,
        description = "Music Equipment",
        client = {
            image = "musicequipment.png",
        }
    },

	['ammonium_nitrate'] = {
		label = 'Ammonium Nitrate',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	['n2o_strawberry'] = {
		label = 'N₂O Tank (Strawberry)',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	['n2o_strawberry_empty'] = {
		label = 'N₂O Tank (Empty, Strawberry)',
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	["n2o_watermelon"] = {
		label = "N₂O Tank (Watermelon)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	["n2o_watermelon_empty"] = {
		label = "N₂O Tank (Empty, Watermelon)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	["n2o_grape"] = {
		label = "N₂O Tank (Grape)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	["n2o_grape_empty"] = {
		label = "N₂O Tank (Empty, Grape)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	
	["n2o_mango"] = {
		label = "N₂O Tank (Mango)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	["n2o_mango_empty"] = {
		label = "N₂O Tank (Empty, Mango)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	
	["n2o_raspberry"] = {
		label = "N₂O Tank (Raspberry)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	["n2o_raspberry_empty"] = {
		label = "N₂O Tank (Empty, Raspberry)",
		weight = 1,
		stack = true,
		close = true,
		description = nil
	},
	["nitrous_compressor"] = {
		label = "Nitrous Compressor",
		weight = 1,
		stack = true,
		close = true,
		description = "A device used to compress ammonium nitrate into nitrous oxide."
	},

	------kevin rentals------
	["rentalpapers"] = {
		label = "Rental Documents",
		weight = 0,
		stack = false,
		close = true,
		client = {
			image = "documents.png",
		}
	},
	["rentalkeys"] = {
		label = "Rental Keys",
		weight = 0,
		stack = false,
		close = true,
		client = {
			image = "rentalkeys.png",
			export = 'kevin-rentals.usekeys'
		}
	},

	["rental_paper"] = {
		label = "Rental Paper",
		weight = 0,
		stack = false,
		close = true,
		description = 'Proof of rental agreement',
	},

	["basicdecrypter"] = {
		label = "Basic Decrypter",
		weight = 1000,
		stack = false,
		close = true,
		decay = true,
		degrade = 2400, ------ 40 hours
		description = "",
		client = {
			image = "basicdecrypter.png",
		}
	},

	----rahe boosting-----
	['hackingdevice'] = {
		label = 'Hacking device',
		weight = 0,
		description = 'Will allow you to bypass vehicle security systems.',
		client = {
		export = 'rahe-boosting.hackingdevice',
		}
	},
	['gpshackingdevice'] = {
		label = 'GPS hacking device',
		weight = 0,
		description = 'If you wish to disable vehicle GPS systems.',
		client = {
		export = 'rahe-boosting.gpshackingdevice',
		}
	},

	["boombox"] = {
		label = "BoomBox",
		weight = 1,
		stack = false,
		close = true,
		description = "A device used to play your favorite tunes!."
	},

	------kevin bounty
	["bounty_bag"] = {
		label = "Bounty Bag",
		weight = 1,
		stack = false,
		close = true,
		description = "Bounty Bag!."
	},
	["bounty_contract"] = {
		label = "Bounty Contract",
		weight = 1,
		stack = false,
		close = true,
		description = "A Bounty contract."
	},
	["empty_bounty_bag"] = {
		label = "Empty Bounty Bag",
		weight = 1,
		stack = false,
		close = true,
		description = "Empty Bounty Bag!."
	},
	['cocaine_leaf'] = {
		label = 'Cocaine leaf',
		weight = 10,
		stack = true,
		close = true,
		description = 'The first step on the road to ruin.'
	},
	
	['trimmer'] = {
		label = 'Trimmer',
		weight = 500,
		stack = true,
		close = true,
		description = 'Not your everyday garden tool.'
	},
	
	['cement'] = {
		label = 'Cement',
		weight = 1000,
		stack = true,
		close = true,
		description = 'Builds more than just buildings.'
	},
	
	['cocaine_extract'] = {
		label = 'Cocaine extract',
		weight = 25,
		stack = true,
		close = true,
		description = 'Pure power from nature’s fury.'
	},

	
	['calcium_hydroxide'] = {
		label = 'Calcium hydroxide',
		weight = 10,
		stack = true,
		close = true,
		description = 'From construction to destruction.'
	},
	
	['kerosene'] = {
		label = 'Kerosene',
		weight = 500,
		stack = true,
		close = true,
		description = 'Fuel for fire, and other things.'
	},
	
	['filter'] = {
		label = 'Filter',
		weight = 1000,
		stack = true,
		close = true,
		description = 'Purity is its game.'
	},
	
	['cocaine_paste'] = {
		label = 'Cocaine paste',
		weight = 50,
		stack = true,
		close = true,
		description = 'Sticky and dangerous.'
	},
	
	['cocaine_brick'] = {
		label = 'Cocaine brick',
		weight = 500,
		stack = true,
		close = true,
		description = 'The solid form of trouble.'
	},
	
	['cocaine_baggy'] = {
		label = 'Cocaine baggy',
		weight = 10,
		stack = true,
		close = true,
		description = 'Small bag, big problems.'
	},
	
	['kerosene_canister'] = {
		label = 'Canister',
		weight = 250,
		stack = true,
		close = true,
		description = 'Handle with care.'
	},
	
	['sodium_bicarbonate'] = {
		label = 'Sodium bicarbonate',
		weight = 50,
		stack = true,
		close = true,
		description = 'Not just for baking.'
	},
	
	['cement_bag'] = {
		label = 'Cement bag',
		weight = 100,
		stack = true,
		close = true,
		description = 'Weighty with potential.'
	},
	
	['drug_bag'] = {
		label = 'Drug bag',
		weight = 10,
		stack = true,
		close = true,
		description = 'Dealers delight.'
	},
	
	['cocaine_mix'] = {
		label = 'Cocaine mix',
		weight = 200,
		stack = true,
		close = true,
		description = 'A recipe for disaster.'
	},
	
	['cocaine_powder'] = {
		label = 'Cocaine powder',
		weight = 150,
		stack = true,
		close = true,
		description = 'Addiction in powder form.'
	},
	
	['grater'] = {
		label = 'Grater',
		weight = 100,
		stack = true,
		close = true,
		description = 'A shredder of norms.'
	},
	
	['overcoocked_cocaine_brick'] = {
		label = 'Overcoocked cocaine brick',
		weight = 70,
		stack = true,
		close = true,
		description = 'A brick of mishaps.'
	},
	
	['mix_in_barrel'] = {
		label = 'Mix in Barrel',
		weight = 2000,
		stack = true,
		close = true,
		description = 'Cocktail of chaos.'
	},
	
	['gas_mask'] = {
		label = 'Gas mask',
		weight = 100,
		stack = true,
		close = true,
		description = 'Breath of safety.'
	},
	['xphone'] = {
		label = 'xphone',
		weight = 100,
		stack = true,
		close = true,
		description = 'Gang Phone.'
	},
	clothes = {
    label = "clothes",
    weight = 1000,
    stack = false,
    description = "A mix of clothes to wear",
	},
	['eighth-baggy'] = {
		label = 'eighth baggy',
		weight = 70,
		stack = true,
		close = true,
		description = 'A bag of smoke.'
	},
	['half-ounce-weed'] = {
		label = 'Half ounce',
		weight = 70,
		stack = true,
		close = true,
		description = 'A half ounce of smoke.'
	},
	['ounce_weed'] = {
		label = 'ounce',
		weight = 70,
		stack = true,
		close = true,
		description = 'A ounce of smoke.'
	},

	['newsbmic'] = {
		label = 'pole News mic',
		weight = 70,
		stack = true,
		close = true,
		description = 'A Microphone.'
	},
	['newscam'] = {
		label = 'News Cam',
		weight = 70,
		stack = true,
		close = true,
		description = 'caught in 4k.'
	},
	['newsmic'] = {
		label = 'Hand News Mic',
		weight = 70,
		stack = true,
		close = true,
		description = 'Speak up.'
	},
	['newspaper'] = {
		label = 'Newspaper',
		weight = 70,
		stack = true,
		close = true,
		description = 'Black and white and red all over.'
	},

	['delivery_box'] = {
        label = 'Delivery Box',
        weight = 5000,
        stack = false,
        close = true,
        description = 'A box ready for delivery'
    },
    
    ['damaged_box'] = {
        label = 'Damaged Box (50% Value)',
        weight = 5000,
        stack = false,
        close = true,
        description = 'A damaged delivery box with reduced value'
    },

	['small_backpack'] = {
		label = 'Small Backpack',
		weight = 100,
		stack = false,
		close = false,
		consume = 0,
		client = {
			image = 'backpack.png'
		}
	},

	["alive_chicken"] = {
		label = "Living chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["blowpipe"] = {
		label = "Blowtorch",
		weight = 2,
		stack = true,
		close = true,
	},

	["bread"] = {
		label = "Bread",
		weight = 1,
		stack = true,
		close = true,
	},

	["cannabis"] = {
		label = "Cannabis",
		weight = 3,
		stack = true,
		close = true,
	},

	["carokit"] = {
		label = "Body Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["carotool"] = {
		label = "Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["clothe"] = {
		label = "Cloth",
		weight = 1,
		stack = true,
		close = true,
	},

	["cutted_wood"] = {
		label = "Cut wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["essence"] = {
		label = "Gas",
		weight = 1,
		stack = true,
		close = true,
	},

	["fabric"] = {
		label = "Fabric",
		weight = 1,
		stack = true,
		close = true,
	},

	["fixkit"] = {
		label = "Repair Kit",
		weight = 3,
		stack = true,
		close = true,
	},

	["fixtool"] = {
		label = "Repair Tools",
		weight = 2,
		stack = true,
		close = true,
	},

	["gazbottle"] = {
		label = "Gas Bottle",
		weight = 2,
		stack = true,
		close = true,
	},

	["gold"] = {
		label = "Gold",
		weight = 1,
		stack = true,
		close = true,
	},

	["marijuana"] = {
		label = "Marijuana",
		weight = 2,
		stack = true,
		close = true,
	},

	["packaged_chicken"] = {
		label = "Chicken fillet",
		weight = 1,
		stack = true,
		close = true,
	},

	["packaged_plank"] = {
		label = "Packaged wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol"] = {
		label = "Oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["petrol_raffin"] = {
		label = "Processed oil",
		weight = 1,
		stack = true,
		close = true,
	},

	["slaughtered_chicken"] = {
		label = "Slaughtered chicken",
		weight = 1,
		stack = true,
		close = true,
	},

	["stone"] = {
		label = "Stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["washed_stone"] = {
		label = "Washed stone",
		weight = 1,
		stack = true,
		close = true,
	},

	["wood"] = {
		label = "Wood",
		weight = 1,
		stack = true,
		close = true,
	},

	["wool"] = {
		label = "Wool",
		weight = 1,
		stack = true,
		close = true,
	},

	["largemouthbass"] = {
    label = "Largemouth Bass",
    weight = 3000,
    stack = true,
    close = true,
    description = "Fish for Fishing.",
    client = {
        image = "largemouthbass.png",
    },
    name = "largemouthbass",
    type = "item",
    image = "largemouthbass.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["item_bench"] = {
    label = "Workbench",
    weight = 15000,
    stack = false,
    close = true,
    description = "A workbench to craft items.",
    client = {
        image = "item_bench.png",
    },
    name = "item_bench",
    type = "item",
    image = "item_bench.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishingnet"] = {
    label = "Fish Net",
    weight = 5000,
    stack = false,
    close = true,
    description = "A net used for catching fish!",
    client = {
        image = "fishingnet.png",
    },
    name = "fishingnet",
    type = "item",
    image = "fishingnet.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["emerald"] = {
    label = "Emerald",
    weight = 3000,
    stack = true,
    close = true,
    description = "Emerald",
    client = {
        image = "emerald.png",
    },
    name = "emerald",
    type = "item",
    image = "emerald.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["chestkey"] = {
    label = "Key",
    weight = 1000,
    stack = true,
    close = true,
    description = "A gold key.",
    client = {
        image = "chestkey.png",
    },
    name = "chestkey",
    type = "item",
    image = "chestkey.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["rainbowtrout"] = {
    label = "Rainbowtrout",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for rainbowtrout",
    client = {
        image = "rainbowtrout.png",
    },
    name = "rainbowtrout",
    type = "item",
    image = "rainbowtrout.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["stripedbass"] = {
    label = "Stripedbass",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for stripedbass",
    client = {
        image = "stripedbass.png",
    },
    name = "stripedbass",
    type = "item",
    image = "stripedbass.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["catfish"] = {
    label = "Catfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for catfish",
    client = {
        image = "catfish.png",
    },
    name = "catfish",
    type = "item",
    image = "catfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["swordfish"] = {
    label = "Swordfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for swordfish",
    client = {
        image = "swordfish.png",
    },
    name = "swordfish",
    type = "item",
    image = "swordfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["cookedfish"] = {
    label = "Cookedfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for cookedfish",
    client = {
        image = "cookedfish.png",
    },
    name = "cookedfish",
    type = "item",
    image = "cookedfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishingrod3"] = {
    label = "Fishingrod3",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for fishingrod3",
    client = {
        image = "fishingrod3.png",
    },
    name = "fishingrod3",
    type = "item",
    image = "fishingrod3.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fish"] = {
    label = "Fish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for fish",
    client = {
        image = "fish.png",
    },
    name = "fish",
    type = "item",
    image = "fish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["treasuremap"] = {
    label = "Treasuremap",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for treasuremap",
    client = {
        image = "treasuremap.png",
    },
    name = "treasuremap",
    type = "item",
    image = "treasuremap.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["ruby"] = {
    label = "Ruby",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for ruby",
    client = {
        image = "ruby.png",
    },
    name = "ruby",
    type = "item",
    image = "ruby.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishingbait"] = {
    label = "Fishingbait",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for fishingbait",
    client = {
        image = "fishingbait.png",
    },
    name = "fishingbait",
    type = "item",
    image = "fishingbait.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["treasurechest"] = {
    label = "Treasurechest",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for treasurechest",
    client = {
        image = "treasurechest.png",
    },
    name = "treasurechest",
    type = "item",
    image = "treasurechest.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["attachment_bench"] = {
    label = "Attachment bench",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for attachment_bench",
    client = {
        image = "attachment_bench.png",
    },
    name = "attachment_bench",
    type = "item",
    image = "attachment_bench.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishinglure"] = {
    label = "Fishinglure",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for fishinglure",
    client = {
        image = "fishinglure.png",
    },
    name = "fishinglure",
    type = "item",
    image = "fishinglure.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["perfectlycookedfish"] = {
    label = "Perfectlycookedfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for perfectlycookedfish",
    client = {
        image = "perfectlycookedfish.png",
    },
    name = "perfectlycookedfish",
    type = "item",
    image = "perfectlycookedfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["salmon"] = {
    label = "Salmon",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for salmon",
    client = {
        image = "salmon.png",
    },
    name = "salmon",
    type = "item",
    image = "salmon.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["tunafish"] = {
    label = "Tunafish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for tunafish",
    client = {
        image = "tunafish.png",
    },
    name = "tunafish",
    type = "item",
    image = "tunafish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["tigershark"] = {
    label = "Tigershark",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for tigershark",
    client = {
        image = "tigershark.png",
    },
    name = "tigershark",
    type = "item",
    image = "tigershark.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishinglure2"] = {
    label = "Fishinglure2",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for fishinglure2",
    client = {
        image = "fishinglure2.png",
    },
    name = "fishinglure2",
    type = "item",
    image = "fishinglure2.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["codfish"] = {
    label = "Codfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for codfish",
    client = {
        image = "codfish.png",
    },
    name = "codfish",
    type = "item",
    image = "codfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["eelfish"] = {
    label = "Eelfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for eelfish",
    client = {
        image = "eelfish.png",
    },
    name = "eelfish",
    type = "item",
    image = "eelfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["skillreel"] = {
    label = "Skillreel",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for skillreel",
    client = {
        image = "skillreel.png",
    },
    name = "skillreel",
    type = "item",
    image = "skillreel.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishingfireplace"] = {
    label = "Fishingfireplace",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for fishingfireplace",
    client = {
        image = "fishingfireplace.png",
    },
    name = "fishingfireplace",
    type = "item",
    image = "fishingfireplace.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["yellowdiamond"] = {
    label = "Yellowdiamond",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for yellowdiamond",
    client = {
        image = "yellowdiamond.png",
    },
    name = "yellowdiamond",
    type = "item",
    image = "yellowdiamond.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishingshovel"] = {
    label = "Fishingshovel",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for fishingshovel",
    client = {
        image = "fishingshovel.png",
    },
    name = "fishingshovel",
    type = "item",
    image = "fishingshovel.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["proreel"] = {
    label = "Proreel",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for proreel",
    client = {
        image = "proreel.png",
    },
    name = "proreel",
    type = "item",
    image = "proreel.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["goldfish"] = {
    label = "Goldfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for goldfish",
    client = {
        image = "goldfish.png",
    },
    name = "goldfish",
    type = "item",
    image = "goldfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["redfish"] = {
    label = "Redfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for redfish",
    client = {
        image = "redfish.png",
    },
    name = "redfish",
    type = "item",
    image = "redfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["captainskull"] = {
    label = "Captainskull",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for captainskull",
    client = {
        image = "captainskull.png",
    },
    name = "captainskull",
    type = "item",
    image = "captainskull.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishingrod2"] = {
    label = "Fishingrod2",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for fishingrod2",
    client = {
        image = "fishingrod2.png",
    },
    name = "fishingrod2",
    type = "item",
    image = "fishingrod2.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["killerwhale"] = {
    label = "Killerwhale",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for killerwhale",
    client = {
        image = "killerwhale.png",
    },
    name = "killerwhale",
    type = "item",
    image = "killerwhale.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["sapphire"] = {
    label = "Sapphire",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for sapphire",
    client = {
        image = "sapphire.png",
    },
    name = "sapphire",
    type = "item",
    image = "sapphire.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["bottlemap"] = {
    label = "Bottlemap",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for bottlemap",
    client = {
        image = "bottlemap.png",
    },
    name = "bottlemap",
    type = "item",
    image = "bottlemap.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishingtrowl"] = {
    label = "Fishingtrowl",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for fishingtrowl",
    client = {
        image = "fishingtrowl.png",
    },
    name = "fishingtrowl",
    type = "item",
    image = "fishingtrowl.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["gholfish"] = {
    label = "Gholfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for gholfish",
    client = {
        image = "gholfish.png",
    },
    name = "gholfish",
    type = "item",
    image = "gholfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishingrod"] = {
    label = "Fishingrod",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for fishingrod",
    client = {
        image = "fishingrod.png",
    },
    name = "fishingrod",
    type = "item",
    image = "fishingrod.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["stingraymeat"] = {
    label = "Stingraymeat",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for stingraymeat",
    client = {
        image = "stingraymeat.png",
    },
    name = "stingraymeat",
    type = "item",
    image = "stingraymeat.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["bluefish"] = {
    label = "Bluefish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for bluefish",
    client = {
        image = "bluefish.png",
    },
    name = "bluefish",
    type = "item",
    image = "bluefish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishinganchor"] = {
    label = "Fishinganchor",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for fishinganchor",
    client = {
        image = "fishinganchor.png",
    },
    name = "fishinganchor",
    type = "item",
    image = "fishinganchor.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["sockeyesalmon"] = {
    label = "Sockeyesalmon",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for sockeyesalmon",
    client = {
        image = "sockeyesalmon.png",
    },
    name = "sockeyesalmon",
    type = "item",
    image = "sockeyesalmon.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["rockfish"] = {
    label = "Rockfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for rockfish",
    client = {
        image = "rockfish.png",
    },
    name = "rockfish",
    type = "item",
    image = "rockfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["flyfish"] = {
    label = "Flyfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for flyfish",
    client = {
        image = "flyfish.png",
    },
    name = "flyfish",
    type = "item",
    image = "flyfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["tarponfish"] = {
    label = "Tarponfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for tarponfish",
    client = {
        image = "tarponfish.png",
    },
    name = "tarponfish",
    type = "item",
    image = "tarponfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishinghalibut"] = {
    label = "Fishinghalibut",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for fishinghalibut",
    client = {
        image = "fishinghalibut.png",
    },
    name = "fishinghalibut",
    type = "item",
    image = "fishinghalibut.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["anglerfish"] = {
    label = "Anglerfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for anglerfish",
    client = {
        image = "anglerfish.png",
    },
    name = "anglerfish",
    type = "item",
    image = "anglerfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["kingsalmon"] = {
    label = "Kingsalmon",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for kingsalmon",
    client = {
        image = "kingsalmon.png",
    },
    name = "kingsalmon",
    type = "item",
    image = "kingsalmon.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["mahimahi"] = {
    label = "Mahimahi",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for mahimahi",
    client = {
        image = "mahimahi.png",
    },
    name = "mahimahi",
    type = "item",
    image = "mahimahi.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["crawfish"] = {
    label = "Crawfish",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for crawfish",
    client = {
        image = "crawfish.png",
    },
    name = "crawfish",
    type = "item",
    image = "crawfish.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["oceansturgeon"] = {
    label = "Oceansturgeon",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for oceansturgeon",
    client = {
        image = "oceansturgeon.png",
    },
    name = "oceansturgeon",
    type = "item",
    image = "oceansturgeon.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishinglog"] = {
    label = "Fishinglog",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for fishinglog",
    client = {
        image = "fishinglog.png",
    },
    name = "fishinglog",
    type = "item",
    image = "fishinglog.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["fishingcrabtrap"] = {
    label = "Fishingcrabtrap",
    weight = 1000,
    stack = false,
    close = true,
    description = "Description for fishingcrabtrap",
    client = {
        image = "fishingcrabtrap.png",
    },
    name = "fishingcrabtrap",
    type = "item",
    image = "fishingcrabtrap.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["bluecrab"] = {
    label = "Bluecrab",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for bluecrab",
    client = {
        image = "bluecrab.png",
    },
    name = "bluecrab",
    type = "item",
    image = "bluecrab.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["dungenesscrab"] = {
    label = "Dungenesscrab",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for dungenesscrab",
    client = {
        image = "dungenesscrab.png",
    },
    name = "dungenesscrab",
    type = "item",
    image = "dungenesscrab.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["rockcrab"] = {
    label = "Rockcrab",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for rockcrab",
    client = {
        image = "rockcrab.png",
    },
    name = "rockcrab",
    type = "item",
    image = "rockcrab.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["redcrab"] = {
    label = "Redcrab",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for redcrab",
    client = {
        image = "redcrab.png",
    },
    name = "redcrab",
    type = "item",
    image = "redcrab.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["snowcrab"] = {
    label = "Snowcrab",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for snowcrab",
    client = {
        image = "snowcrab.png",
    },
    name = "snowcrab",
    type = "item",
    image = "snowcrab.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
["cookedcrab"] = {
    label = "Cookedcrab",
    weight = 1000,
    stack = true,
    close = true,
    description = "Description for cookedcrab",
    client = {
        image = "cookedcrab.png",
    },
    name = "cookedcrab",
    type = "item",
    image = "cookedcrab.png",
    unique = false,
    useable = true,
    shouldClose = true,
    combinable = nil,
},
}