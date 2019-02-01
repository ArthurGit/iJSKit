/**
 * Created by ljt-ios-devloper on 2019/1/31.
 */

function jsmothod() {
    window.webkit.messageHandlers.myAction.postMessage("myAction");
    window.webkit.messageHandlers.NativeMethod.postMessage("NativeMethod");
    
    return {"key":"value"}
}
