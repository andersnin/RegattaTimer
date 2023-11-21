import Toybox.Graphics;
import Toybox.WatchUi;
import Toybox.System;

class RegattaTimerView extends WatchUi.View {

    private var _raceTimer;
    private var _clock; 

    function initialize() {
        View.initialize();
    }

    // Load your resources here
    function onLayout(dc as Dc) as Void {
        setLayout(Rez.Layouts.MainLayout(dc));
        _raceTimer = findDrawableById("race_timer");
        _clock = findDrawableById("clock");
    }

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() as Void {
    }

    // Update the view
    function onUpdate(dc as Dc) as Void {
        // Update clock
        setClockValue();
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() as Void {
    }

    function setClockValue() as Void {
        var currentTime = System.getClockTime();

        var timeString = 
            currentTime.hour.format("%02d") + ":" + 
            currentTime.min.format("%02d") + ":" +
            currentTime.sec.format("%02d");

        // Set the text of the _clock drawable
        _clock.setText(timeString);

        // Request a screen update
        WatchUi.requestUpdate();
    }

    function setTimerValue(value, countDirection) as Void {

        var minutes = value/60;
        var seconds = value%60;
        var secondsFormatted = seconds > 9 ? seconds.toString() : "0" + seconds.toString();
        var timeFormatted = minutes.toString() + ":" + secondsFormatted;

        // Change the color based on the current time
        if (!countDirection) {
            if (minutes >= 10) {
                _raceTimer.setColor(Graphics.COLOR_WHITE);
            } else if (minutes >= 5) {
                _raceTimer.setColor(Graphics.COLOR_GREEN);
            } else if (minutes >= 4) {
                _raceTimer.setColor(Graphics.COLOR_YELLOW);
            } else if (minutes >= 1) {
                _raceTimer.setColor(Graphics.COLOR_ORANGE);
            } else {
                _raceTimer.setColor(Graphics.COLOR_RED);
            }   
        } else {
            _raceTimer.setColor(Graphics.COLOR_WHITE);
        }

        _raceTimer.setText(timeFormatted);
        WatchUi.requestUpdate();
    }

}
