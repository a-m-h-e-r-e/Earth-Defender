# Earth-Defender
## Game rules:
Aliens from another planet are attacking the earth
Your space ship is positioned perpendicularly so that you can hit any one who tries to pass.
You have a high energy laser gun, as a result it take time to recharge it.
Time your firing to hit your target.
> You are earth’s last hope, DEFEND THE EARTH! :)

## Game Algorithm
* At every loop first it will check for input
* If there is no command it will do the normal routine
  * Move every one step right
  * Move the laser one step up
  * Check if there is any hit
    * Remove the alien.
    * Remove the laser.
    * Increase the score by one.
  * Check if boundary is passed
    * Terminate the game if passed
  * Decrement boundary by one
  * Loop to step one.
* If there is command check the command
  * If it’s left command, move the ship to the left.
  * If it’s right command, move the ship to the right.
  * If it’s shoot, shoot.
* Loop to step one.

## Installation
Download the emu8086 emulator from [softonic](https://emu8086-microprocessor-emulator.en.softonic.com/download). Install the app and enjoy.
