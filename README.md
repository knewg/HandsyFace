# HandsyFace
Garmin watch face using hands instead of numbers. the hands start at 12 o clock and traverses around the screen as regular watch hands. In the middle, the date is displayed. There are four watch hands, from the outside in:

#### Time hand
Displays the current time the same way a regular hour hand on a watch does. You can see the time with what's usually enough precision, basically every 15 minutes or so.

#### Activity hand
Shows how close you are to your set activity goal for the week.

#### Calories hand
Shows how many calories you have burned during the day. Due to not figuring out the settings system and not having enough energy to research more, a goal is compiled in. It is currently set to 1500 above average MBR (2000 kcal).

#### Steps hand
Shows how close you are to reaching the step goal for the day.

Very simple, and reasonably clean. Not sure if I like it yet.

## Rollaround
A small number is added next to each counter for each doubling of the goal. If your step goal is 5000 and you take 5001 steps, the number will be 1 and the arrow will point straight up.

## Installation instructions
There are two main ways to install this watchface

### Pre built binary
Connect your device to the computer and drop the correct binary for your device in the /GARMIN/APPS-folder. 

### Compile from source
Compile it from source using the [Garmin SDK](https://developer.garmin.com/connect-iq/sdk/)

If you need to resize the icons there is a script for this in the resources/drawables-folder called [renderImages](https://github.com/knewg/HandsyFace/blob/master/resources/drawables/renderImages). This script can be used to render images in any size. Keep in mind that the different icons have different visual impacts, so a slight modification to the script might be needed for sizes other than 15, or 20px. The script automatically updates [drawables.xml](https://github.com/knewg/HandsyFace/blob/master/resources/drawables/drawables.xml).

After using the "build for device wizard", transfer the built binary per the instructions above.

Note: If you are changing the colors, remember to update the drawables file aswell, since garmin does not allow you to repaint icons in run time.

## Attributions
Icons where downloaded from [The Noun Project](https://thenounproject.com/)
The icons used are:

* [calories by Nikhil Bapna](https://thenounproject.com/icon/1180285/)
* [steps by Shiva](https://thenounproject.com/icon/1166846/)
* [Time by Barracuda](https://thenounproject.com/icon/2305857/)
* [activity by mikicon](https://thenounproject.com/icon/1911201/)

## Known limitations
None at the moment

## License
[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)

## Screenshots
Screenshots are located in the [screenshots directory](https://github.com/knewg/HandsyFace/tree/master/screenshots).

![Thumbnail](https://github.com/knewg/HandsyFace/blob/master/screenshots/thumbnail.png)
