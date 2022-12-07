# TeethBrusher
Idle clicker in SwiftUI

## Basic idea
Every tap is a "brush" that cleans one tooth. Clean teeth can be exchanged for workers and upgrades

## Workers
* Dental Hygienist 
* Dentist
* TBD

## Upgrades
* Fluoride
* Electric Toothbrushes
* TBD

## Endgame
There are eight billion people on the planet. Children have 20 baby teeth and adults reach 32 teeth, including wisdom teeth, but those are often removed and people lose teeth so I'll assume an average of 25 teeth per person for simple math meaning there are 200 billion teeth to brush. After this you win the main game but it will continue with either animals or aliens.

## Coding plan
I'll probably save data to UserDefaults. It's easy and there's very little data to save. 

Once workers are acquired the brushing happens automatically, requiring new calculations every "tock" cycle (probably one-second interals). I will start by building the timer functionality. Initially it will update a placeholder that just counts up seconds. That will eventually be replaced with the calculated total teeth brushed.

I think workers will be created as subclasses, inheriting from a parent worker class.
