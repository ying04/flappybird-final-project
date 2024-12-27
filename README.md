# flappybird-final-project
111321050 & 111321036 final project

Flappy Bird LED Simulation

Overview
Flappy Bird LED Simulation is an interactive hardware project built for FPGA or microcontroller platforms. The game replicates the classic Flappy Bird gameplay using an 8x8 LED matrix to display the bird and obstacles, 7-segment displays for scoring, and a buzzer for audio feedback.


Key Features:
-8x8 LED Matrix: Displays the bird and the pipes dynamically.
-7-Segment Display: Shows the player's current score.
-Buzzer Support: Provides audio feedback for collisions or actions.
-User Interaction: Controlled via button inputs for gameplay.


How to Play:

-Controlling the Bird:
Use the player1 button to make the bird jump. If you don’t press it, the bird will gradually fall.

-Avoiding Obstacles:
The bird must pass through the gaps between the moving pipes. If the bird hits a pipe or falls off the screen, the game ends.

-Timer:
There will be a timer that tells you how much time hass pass. If the time reach 60s you win


Objective:
Achieve the highest score possible by navigating the bird through the gaps in the pipes.


Game Over Conditions:
The game ends if the bird collides with a pipe or falls below the screen.


Restarting:
Press the restart button to play again after the game ends.


Modes:
Use the mode button to change difficulty levels or adjust settings before starting the game.


PIN assign : 
COMM[0]	Location	PIN_55
COMM[1]	Location	PIN_58
COMM[2]	Location	PIN_59
COMM[3]	Location	PIN_60
DATA_B[0]	Location	PIN_72
DATA_B[1]	Location	PIN_73
DATA_B[2]	Location	PIN_74
DATA_B[3]	Location	PIN_75
DATA_B[4]	Location	PIN_76
DATA_B[5]	Location	PIN_77
DATA_B[6]	Location	PIN_79
DATA_B[7]	Location	PIN_80
DATA_G[0]	Location	PIN_64
DATA_G[1]	Location	PIN_65
DATA_G[2]	Location	PIN_66
DATA_G[3]	Location	PIN_67
DATA_G[4]	Location	PIN_68
DATA_G[5]	Location	PIN_69
DATA_G[6]	Location	PIN_70
DATA_G[7]	Location	PIN_71
DATA_R[0]	Location	PIN_135
DATA_R[1]	Location	PIN_136
DATA_R[2]	Location	PIN_137
DATA_R[3]	Location	PIN_138
DATA_R[4]	Location	PIN_141
DATA_R[5]	Location	PIN_142
DATA_R[6]	Location	PIN_143
DATA_R[7]	Location	PIN_144
player1	Location	PIN_54
CLK	Location	PIN_22
restart	Location	PIN_53
mode	Location	PIN_52
b	Location	PIN_125
c	Location	PIN_126
d	Location	PIN_127
e	Location	PIN_128
f	Location	PIN_129
g	Location	PIN_132
com[0]	Location	PIN_120
com[1]	Location	PIN_121
a	Location	PIN_124
beep	Location	PIN_119
