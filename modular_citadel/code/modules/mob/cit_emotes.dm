#define INSULTS_FILE "insult.json"

/mob
	var/nextsoundemote = 1

//Disables the custom emote blacklist from TG that normally applies to slimes.
/datum/emote/living/custom
	mob_type_blacklist_typecache = list(/mob/living/brain)

/datum/emote/living/insult
	key = "insult"
	key_third_person = "insults"
	message = "spews insults."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/insult/run_emote(mob/living/user, params)
	var/insult_message = ""
	var/miming = user.mind ? user.mind.miming : 0
	if(!user.is_muzzled())
		insult_message += pick_list_replacements(INSULTS_FILE, "insult_gen")
		message = insult_message
	else if(miming)
		message = "creatively gesticulates."
	else
		message = "muffles something."
	. = ..()

/datum/emote/living/scream/run_emote(mob/living/user, params) //I can't not port this shit, come on.
	if(user.nextsoundemote >= world.time || user.stat != CONSCIOUS)
		return
	var/sound
	var/miming = user.mind ? user.mind.miming : 0
	if(!user.is_muzzled() && !miming)
		user.nextsoundemote = world.time + 7
		if(issilicon(user))
			sound = 'modular_citadel/sound/voice/scream_silicon.ogg'
			if(iscyborg(user))
				var/mob/living/silicon/robot/S = user
				if(S.cell.charge < 20)
					to_chat(S, "<span class='warning'>Scream module deactivated. Please recharge.</span>")
					return
				S.cell.use(200)
		if(ismonkey(user))
			sound = 'modular_citadel/sound/voice/scream_monkey.ogg'
		if(istype(user, /mob/living/simple_animal/hostile/gorilla))
			sound = 'sound/creatures/gorilla.ogg'
		if(ishuman(user))
			user.adjustOxyLoss(5)
			sound = pick('hyperstation/sound/voice/emotes/male_scream1.ogg', 'hyperstation/sound/voice/emotes/male_scream2.ogg', 'hyperstation/sound/voice/emotes/male_scream3.ogg')
			if(user.gender == FEMALE)
				sound = pick('hyperstation/sound/voice/emotes/female_scream1.ogg', 'hyperstation/sound/voice/emotes/female_scream1b.ogg')
			if(is_species(user, /datum/species/android) || is_species(user, /datum/species/synth) || is_species(user, /datum/species/ipc) || is_species(user, /datum/species/synthliz))
				sound = 'modular_citadel/sound/voice/scream_silicon.ogg'
			if(is_species(user, /datum/species/lizard))
				sound = 'modular_citadel/sound/voice/scream_lizard.ogg'
			if(is_species(user, /datum/species/skeleton))
				sound = 'modular_citadel/sound/voice/scream_skeleton.ogg'
			if (is_species(user, /datum/species/fly) || is_species(user, /datum/species/insect))
				sound = 'modular_citadel/sound/voice/scream_moth.ogg'
		if(isalien(user))
			sound = 'sound/voice/hiss6.ogg'
		LAZYINITLIST(user.alternate_screams)
		if(LAZYLEN(user.alternate_screams))
			sound = pick(user.alternate_screams)
		playsound(user.loc, sound, 50, 1, 4, 1.2)
		message = "screams!"
	else if(miming)
		message = "acts out a scream."
	else
		message = "makes a very loud noise."
	. = ..()

/datum/emote/sound/carbon/snap
	key = "snap"
	key_third_person = "snaps"
	muzzle_ignore = TRUE
	restraint_check = TRUE
	emote_type = EMOTE_AUDIBLE
	sound = 'sound/effects/snap01.ogg'
	mob_type_allowed_typecache = list(/mob/living/carbon/)


/datum/emote/living/snap
	key = "snap"
	key_third_person = "snaps"
	message = "snaps their fingers."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/snap/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_citadel/sound/voice/snap.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/snap2
	key = "snap2"
	key_third_person = "snaps twice"
	message = "snaps twice."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/snap2/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_citadel/sound/voice/snap2.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/snap3
	key = "snap3"
	key_third_person = "snaps thrice"
	message = "snaps thrice."
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/snap3/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_citadel/sound/voice/snap3.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/awoo
	key = "awoo"
	key_third_person = "lets out an awoo"
	message = "lets out an awoo!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/awoo/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_citadel/sound/voice/awoo.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/nya
	key = "nya"
	key_third_person = "lets out a nya"
	message = "lets out a nya!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/nya/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_citadel/sound/voice/nya.ogg', 50, 1, -1)
	. = ..()

//h13 emote	*bleat

/datum/emote/living/bleat
	key = "bleat"
	key_third_person = "bleats loudly"
	message = "bleats loudly!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/bleat/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_citadel/sound/voice/bleat.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/weh
	key = "weh"
	key_third_person = "lets out a weh"
	message = "lets out a weh!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/weh/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_citadel/sound/voice/weh.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/peep
	key = "peep"
	key_third_person = "peeps like a bird"
	message = "peeps like a bird!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/peep/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_citadel/sound/voice/peep.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/dab
	key = "dab"
	key_third_person = "suddenly hits a dab"
	message = "suddenly hits a dab!"
	emote_type = EMOTE_AUDIBLE
	restraint_check = TRUE

//hs13
/datum/emote/living/fingergun
	key = "fingergun"
	key_third_person = "uses their hand to mimic a handgun and points"
	message = "uses their hand to mimic a handgun and points!"
	emote_type = EMOTE_AUDIBLE
	restraint_check = TRUE

/datum/emote/living/mothsqueak
	key = "msqueak"
	key_third_person = "lets out a tiny squeak"
	message = "lets out a tiny squeak!"
	emote_type = EMOTE_AUDIBLE
	mob_type_allowed_typecache = list(/mob/living/carbon)

/datum/emote/living/mothsqueak/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_citadel/sound/voice/mothsqueak.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/merp
	key = "merp"
	key_third_person = "merps"
	message = "merps!"
	emote_type = EMOTE_AUDIBLE

/datum/emote/living/merp/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_citadel/sound/voice/merp.ogg', 50, 1, -1)
	. = ..()

/datum/emote/living/bark
	key = "bark"
	key_third_person = "barks like a dog!"
	message = "barks like a dog!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE
	mob_type_allowed_typecache = list(/mob/living/carbon, /mob/living/silicon/pai)

/datum/emote/living/bark/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	var/path = pick(list('modular_citadel/sound/voice/bark.ogg', 'modular_citadel/sound/voice/bark1.ogg', 'modular_citadel/sound/voice/bark2.ogg'))
	playsound(user, path, 50, 1, -1)

/datum/emote/living/hiss
	key = "hiss"
	key_third_person = "hisses"
	message = "hisses!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE

/datum/emote/living/hiss/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_citadel/sound/voice/hiss.ogg', 50, 1, -1)

/datum/emote/living/meow
	key = "meow"
	key_third_person = "mrowls"
	message = "mrowls!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE

/datum/emote/living/cackle
	key = "cackle"
	key_third_person = "cackles"
	message = "cackles hysterically!"
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE

/datum/emote/living/cackle/run_emote(mob/living/user, params)
	if(ishuman(user))
		if(user.nextsoundemote >= world.time)
			return
		user.nextsoundemote = world.time + 7
		playsound(user, 'modular_citadel/sound/voice/cackle_yeen.ogg', 50, 1, -1)
	. = ..()


/datum/emote/living/meow/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_citadel/sound/voice/meow1.ogg', 50, 1, -1)

/datum/emote/living/purr
	key = "purr"
	key_third_person = "purrs softly"
	message = "purrs softly."
	emote_type = EMOTE_AUDIBLE
	muzzle_ignore = FALSE
	restraint_check = FALSE

/datum/emote/living/purr/run_emote(mob/living/user, params)
	if(!(. = ..()))
		return
	if(user.nextsoundemote >= world.time)
		return
	user.nextsoundemote = world.time + 7
	playsound(user, 'modular_citadel/sound/voice/purr.ogg', 50, 1, -1)
