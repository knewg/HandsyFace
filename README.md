# HandsyFace
Garmin watch face using hands instead of numbers.

Very simple, and reasonably clean. Not sure I like it yet.

## Installation instructions
There are two main ways to install this watchface

### Pre built binary
Connect your device to the computer and drop the correct binary for your device in the /GARMIN/APPS-folder. 

### Compile from source
Compile it from source using the [Garmin SDK](https://developer.garmin.com/connect-iq/sdk/)

If you need to resize the icons there is a script for this in the resources/drawables-folder called [renderImages](https://github.com/knewg/HandsyFace/blob/master/resources/drawables/renderImages). This script can be used to render images in any size. Keep in mind that the different icons have different visual impacts, so a slight modification to the script might be needed for sizes other than 15, or 20px. The script automatically updates [drawables.xml](https://github.com/knewg/HandsyFace/blob/master/resources/drawables/drawables.xml).

After using the "build for device wizard", transfer the built binary per the instructions above.

## Attributions
Icons where downloaded from [The Noun Project](https://thenounproject.com/)
The icons used are:

* [calories by Nikhil Bapna](https://thenounproject.com/icon/1180285/)
* [steps by Shiva](https://thenounproject.com/icon/1166846/)
* [Time by Barracuda](https://thenounproject.com/icon/2305857/)
* [activity by mikicon](https://thenounproject.com/icon/1911201/)

## License
[CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/)

## Screenshots
Screenshots are located in the [screenshots directory](https://github.com/knewg/HandsyFace/tree/master/screenshots).
