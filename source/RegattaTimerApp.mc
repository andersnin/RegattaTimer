import Toybox.Application;
import Toybox.Lang;
import Toybox.WatchUi;

class RegattaTimerApp extends Application.AppBase {

    private var _view;

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state as Dictionary?) as Void {
    }

    // onStop() is called when your application is exiting
    function onStop(state as Dictionary?) as Void {
    }

    // Return the initial view of your application here
    function getInitialView() as Array<Views or InputDelegates>? {
        _view = new RegattaTimerView();
        return [ _view, new RegattaTimerDelegate() ] as Array<Views or InputDelegates>;
    }

    function getView() as RegattaTimerView {
        return _view;
    }
}

function getApp() as RegattaTimerApp {
    return Application.getApp() as RegattaTimerApp;
}

function getView() as RegattaTimerView {
    return Application.getApp().getView();
}