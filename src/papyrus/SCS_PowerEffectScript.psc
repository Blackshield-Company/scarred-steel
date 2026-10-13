Scriptname SCS_PowerEffectScript extends ActiveMagicEffect
{Scarred Steel - the lesser power shows current wear.}

SCS_WearScript Property Wear Auto

Event OnEffectStart(Actor akTarget, Actor akCaster)
	If akCaster == Game.GetPlayer()
		Wear.UsePower()
	EndIf
EndEvent
