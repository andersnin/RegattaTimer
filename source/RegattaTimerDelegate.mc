import Toybox.Lang;
import Toybox.WatchUi;
import Toybox.Timer;
import Toybox.Attention;
import Toybox.Test;

class RegattaTimerDelegate extends WatchUi.BehaviorDelegate {

    private static var duration = 600;
    
    private var _timer;
    private var _timeLeft;
    private var _vibrationCount;
    private var _vibrationTimer;
    private var _countUp = false;
    private var _countdownInProgress = false;

    private var _view = getView();

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() as Boolean {  
        _timeLeft = duration;
        
        if (_countdownInProgress == false) {
            _countdownInProgress = true;
            startCountdown();
        } else if (_countdownInProgress == true) {
            _countdownInProgress = false;
            _countUp = false;
            _timer.stop();
            _view.setTimerValue(_timeLeft, _countUp);
        }
        return true;
    }

    function onBack() {
        // Check if the timer is running
        if (_countdownInProgress == true && _countUp == false) {
            // If the time left is more than 5 minutes, jump to 5 minutes
        if (_timeLeft > 5 * 60) {
            _timeLeft = (5 * 60);
        }
        // If the time left is more than 4 minutes, jump to 4 minutes
        else if (_timeLeft > 4 * 60) {
            _timeLeft = (4 * 60);
        }
        // If the time left is more than 1 minute, jump to 1 minute
        else if (_timeLeft > 1 * 60) {
            _timeLeft = (1 * 60);
        }

            return true;
        } else {
            return false;
        }
    }

    function startCountdown() {
        _timer = new Timer.Timer();
        _timer.start(method(:updateCountdownValue), 1000, true);
    }

    function updateCountdownValue() as Void {
        if (_timeLeft == 0) {
            _countUp = true;
            if (Attention has :vibrate) {
                Attention.vibrate([new Attention.VibeProfile(100, 1000)]); // On for 1 second
            }
        }

        if (_countUp) {
            _timeLeft++;
        } else {
            _timeLeft--;
        }

        // Vibrate the number of minutes when the timer passes each minute from 5 and down
        if (_timeLeft % 60 == 0 && _timeLeft / 60 <= 5) {
            _vibrationCount = (_timeLeft / 60);
            vibrate();  // Vibrate every half second
        }
        _view.setTimerValue(_timeLeft, _countUp);
    }

    function vibrate() as Void {
        if (Attention has :vibrate && _vibrationCount > 0) {
            Attention.vibrate([new Attention.VibeProfile(100, 100)]); // On for 1/10 of a second
            // Call this function again after half a second
            _vibrationCount--;
            _vibrationTimer = new Timer.Timer();
            _vibrationTimer.start(method(:vibrate), 500, false);
        }
    }
}