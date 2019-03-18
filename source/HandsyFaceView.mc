using Toybox.WatchUi;
using Toybox.Graphics;
using Toybox.System;
using Toybox.Lang;
using Toybox.Time.Gregorian;
using Toybox.Application;
using Toybox.ActivityMonitor;

class HandsyFaceView extends WatchUi.WatchFace {

	var screenCenterPoint;
	var hands;
	var handKeys;
	var numHandKeys;
	var angles;
	var hourAngles;
	
	var bmr = 2000.0;
	var caloriesGoal = 1500.0;
	
	var split = 6;
	var handLength;
	
	/*	var hourHandOffset;
		var calorieHandOffset;
		var stepsHandOffset;
		var recoveryHandOffset;
		var calorieIconWidth;
        var calorieIconHeightDiff;
        var timeIconWidth;
        var timeIconHeightDiff;
        var stepsIconWidth;
        var stepsIconHeightDiff;
        var activityIconWidth;
        var activityIconHeightDiff;*/

    function initialize() {
        WatchFace.initialize();
    }

    // Load your resources here
    function onLayout(dc) {
        //setLayout(Rez.Layouts.WatchFace(dc));
		screenCenterPoint = [dc.getWidth() / 2, dc.getHeight() / 2];
		handLength = screenCenterPoint[0]/split;
        hands = {
        	"calories" => {
        		"icon" => WatchUi.loadResource(Rez.Drawables.caloriesIcon),
        		"color" => Graphics.COLOR_BLUE,
        	},
        	"steps" => {
        		"icon" => WatchUi.loadResource(Rez.Drawables.stepsIcon),
        		"color" => Graphics.COLOR_GREEN
        	},
        	"time" => {
        		"icon" => WatchUi.loadResource(Rez.Drawables.timeIcon),
        		"color" => Graphics.COLOR_RED
        	},
        	"activity" => {
        		"icon" => WatchUi.loadResource(Rez.Drawables.activityIcon),
        		"color" => Graphics.COLOR_PINK	
        	}
        };
        handKeys = hands.keys();
        numHandKeys = handKeys.size();
        hourAngles = new [12]; 
        angles = new [numHandKeys];
        for(var i = 0; i < numHandKeys; i++) //Loop through everything and calculate it
        {
        	var hand = hands[handKeys[i]];
        	hand["order"] = i;
        	hand["offset"] = screenCenterPoint[0] - (handLength * (i + 1));
        	hand["iconWidth"] = hand["icon"].getWidth();
        	hand["iconHeight"] = hand["icon"].getHeight();
        	hand["iconHeightDiff"] = (handLength - hand["iconHeight"]) / 2;
        }
        
        // Pre calculate all the angles for the hours and keep them in memory.
        hourAngles[0] = 0;
        for(var i = 1; i < 12; i++)
        {
        	hourAngles[i] = (i / 12.0) * Math.PI * 2.0;
        }
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    }

    // Update the view
    function onUpdate(dc) {
		var info = ActivityMonitor.getInfo();

		// Get step data
		var stepAngle = (info.steps / (info.stepGoal * 2.0)) * (2.0 * Math.PI);
		angles[hands["steps"]["order"]] = stepAngle; 
		
		// Get calorie data
		var calorieAngle = (info.calories / (bmr + caloriesGoal * 2.0)) * (2.0 * Math.PI);
		angles[hands["calories"]["order"]] = calorieAngle;
		
		// Get active minute data
		var activeMinutesAngle = (info.activeMinutesWeek.total / (info.activeMinutesWeekGoal * 2.0)) * (2 * Math.PI);
		angles[hands["activity"]["order"]] = activeMinutesAngle;
		
		// Get time data
		var clockTime = System.getClockTime();
		var thisHour = (clockTime.hour % 12);
		var nextHour = (thisHour+1) % 12;
		var nextNextHour = (thisHour+2) % 12;
		var hourHandAngle = ((thisHour * 60) + clockTime.min);
        hourHandAngle = hourHandAngle / (12 * 60.0);
        hourHandAngle = hourHandAngle * Math.PI * 2;
        angles[hands["time"]["order"]] = hourHandAngle;
		
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        
        // Print date in the middle of the screen
        dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_TRANSPARENT);
        var calendar = Gregorian.info(Time.now(), Time.FORMAT_LONG);
        var dateStr = Lang.format("$1$ $2$", [calendar.month, calendar.day]);
        var fontHeight = Graphics.getFontHeight(Graphics.FONT_TINY);
        dc.drawText(screenCenterPoint[0], screenCenterPoint[1]-(fontHeight/2), Graphics.FONT_TINY, dateStr, Graphics.TEXT_JUSTIFY_CENTER);
        
        // Draw hour helper hands
        var helperHandLength = handLength / 3;
        dc.fillPolygon(generateHandCoordinates(screenCenterPoint, hourAngles[nextHour], helperHandLength, 0, hands["time"]["offset"] + (handLength - helperHandLength), 3));
        dc.setColor(Graphics.COLOR_DK_GRAY, Graphics.COLOR_TRANSPARENT);
        dc.fillPolygon(generateHandCoordinates(screenCenterPoint, hourAngles[thisHour], helperHandLength, 0, hands["time"]["offset"] + (handLength - helperHandLength), 3));
        dc.fillPolygon(generateHandCoordinates(screenCenterPoint, hourAngles[nextNextHour], helperHandLength, 0, hands["time"]["offset"] + (handLength - helperHandLength), 3));
        
        for(var i = 0; i < numHandKeys; i++) //Loop through everything and calculate it
        {
        	var hand = hands[handKeys[i]];
        	dc.setColor(hand["color"], Graphics.COLOR_TRANSPARENT);
        	dc.fillPolygon(generateHandCoordinates(screenCenterPoint, angles[i], handLength, 0, hand["offset"], 3));
        	dc.drawBitmap( screenCenterPoint[0]-hand["iconWidth"]/2, screenCenterPoint[1] + hand["iconHeightDiff"] +(screenCenterPoint[1] / split * (split-i-1)), hand["icon"]);
        }
    }
    
    
    
    function generateHandCoordinates(centerPoint, angle, handLength, tailLength, offset, width) {
        // Map out the coordinates of the watch hand
        var coords = [[-(width / 2), tailLength-offset], [-(width / 2), -handLength-offset], [width / 2, -handLength-offset], [width / 2, tailLength-offset]];
        // [[-1.5, 0], [-1.5, -40], [1.5, -40], [1.5, 0]]
        var result = new [4];
        var cos = Math.cos(angle);
        var sin = Math.sin(angle);

        // Transform the coordinates
        for (var i = 0; i < 4; i += 1) {
            var x = (coords[i][0] * cos) - (coords[i][1] * sin) + 0.5;
            var y = (coords[i][0] * sin) + (coords[i][1] * cos) + 0.5;

            result[i] = [centerPoint[0] + x, centerPoint[1] + y];
        }

        return result;
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}
