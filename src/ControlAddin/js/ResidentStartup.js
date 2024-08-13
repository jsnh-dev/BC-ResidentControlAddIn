var iframe = window.frameElement;
var iframeId = iframe.getAttribute('id');
var parent = iframe.parentElement.parentElement.parentElement.parentElement;

window.StartListening = function StartListening(baseUrl, settings) {
    parent.style.display = 'none';

    let windowTopHead = window.top.document.querySelector('head');
    let mainScriptId = 'residentMainScript';

    /* Plant the script in the main document. */
    if (!windowTopHead.querySelectorAll("script#" + mainScriptId).length) {
        const mainScript = window.top.document.createElement("script");
        mainScript.setAttribute("type", "text/javascript");
        mainScript.setAttribute("id", mainScriptId);
        mainScript.innerHTML =
            /* Go back to baseUrl (Role Center) where the control add-in is implemented when BC gets refreshed. */
            "window.onbeforeunload = function (e) { " +
            "    window.setTimeout(function () { " +
            "       e.preventDefault(); " +
            "       e.stopPropagation(); " +
            "       e.stopImmediatePropagation(); " +
            "       window.location.href = '" + baseUrl + "'; " +
            "    }, 0); " +
            "    window.onbeforeunload = null; " +
            "}; " +

            "window.residentIframe = document.querySelectorAll('iframe')[0].contentDocument.querySelector('#" + iframeId + "'); " +

            /* Save the current page in a cookie. */
            "window.residentSetPage = function residentSetPage() {" +
            "   let urlParams = new URLSearchParams(window.location.href); " +
            "   let residentPage = urlParams.get('page'); " +
            "   document.cookie = 'residentPage=' + residentPage + ';'; " +
            "}; " +

            /* Check if there is a page saved in a cookie. Navigate to it if so. */
            "window.residentCheckPage = function residentCheckPage() {" +
            "    let residentPage = residentGetCookie('residentPage'); " +
            "    if (residentPage) { " +
            "        residentIframe.contentWindow.OnGetPage(residentPage); " +
            "    } " +
            "    return; " +
            "}; " +

            "window.residentGetCookie = function residentGetCookie(cname) { " +
            "    let name = cname + '='; " +
            "    let decodedCookie = decodeURIComponent(document.cookie); " +
            "    let ca = decodedCookie.split(';'); " +
            "    for(let i = 0; i < ca.length; i++) { " +
            "      let c = ca[i]; " +
            "      while (c.charAt(0) == ' ') { " +
            "        c = c.substring(1); " +
            "      } " +
            "      if (c.indexOf(name) == 0) { " +
            "        return c.substring(name.length, c.length); " +
            "      } " +
            "    } " +
            "    return ''; " +
            "}; " +

            /* To be called when planted. */
            "window.residentStartListeningMain = function residentStartListeningMain(settings) {" +
            "    residentCheckPage(); " +

            "    residentMoveScripts(settings);" +

            "    var listElm = window.document.querySelectorAll('iframe')[0].contentDocument.querySelector('.spa-container');" +

            "    residentObserveDOM(listElm, function (m) {" +
            "        var newSpa = false; " +

            "        m.forEach((record) => { " +
            "           record.addedNodes.forEach((e) => { " +
            "               if (e.classList.contains('spa-normal')) { " +
            "                   newSpa = true; " +
            "               } " +
            "           }); " +
            "           record.removedNodes.forEach((e) => { " +
            "               if (e.classList.contains('spa-normal')) { " +
            "                   newSpa = true; " +
            "               } " +
            "           }); " +
            "        }); " +

            "        if (newSpa) { " +
            "           window.setTimeout(function () {" +
            "               residentSetPage();" +
            "           }, 500);" +
            "        } " +
            "    }); " +
            "}; " +

            /* Move the control add-in styles (and scripts) to the main document. */
            "window.residentMoveScripts = function residentMoveScripts(settings) {" +
            "    if (!residentIframe.contentDocument) { " +
            "       return; " +
            "    } " +

            "    var residentHead = residentIframe.contentDocument.querySelector('head');" +
            "    var mainHead = window.document.querySelectorAll('iframe')[0].contentDocument.querySelector('head'); " +

            "    if (!mainHead.querySelectorAll(\"link[href*='Resident.css']\").length) {" +
            "       var iframeCss = residentHead.querySelector(\"link[href*='Resident.css']\").cloneNode(true);" +
            "       mainHead.appendChild(iframeCss);" +
            "    }" +

            "    if (darkmode) {" +
            "       if (!mainHead.querySelectorAll(\"link[href*='ResidentDarkmode.css']\").length) {" +
            "           var darkmodeCSS = residentHead.querySelector(\"link[href*='ResidentDarkmode.css']\").cloneNode(true);" +
            "           mainHead.appendChild(darkmodeCSS);" +
            "       }" +
            "    } else {" +
            "       if (mainHead.querySelectorAll(\"link[href*='ResidentDarkmode.css']\").length) {" +
            "           mainHead.querySelector(\"link[href*='ResidentDarkmode.css']\").remove();" +
            "       }" +
            "    }" +

            "}; " +

            "window.residentObserveDOM = (function () { " +
            "    var MutationObserver = window.MutationObserver || window.WebKitMutationObserver; " +

            "    return function (obj, callback) { " +
            "        if (!obj || obj.nodeType !== 1) return; " +

            "        if (MutationObserver) { " +
            "            var mutationObserver = new MutationObserver(callback); " +

            "            mutationObserver.observe(obj, { childList: true, subtree: false }); " +
            "            return mutationObserver; " +
            "        } " +

            "        else if (window.addEventListener) { " +
            "            obj.addEventListener('DOMNodeInserted', callback, false); " +
            "            obj.addEventListener('DOMNodeRemoved', callback, false); " +
            "        } " +
            "    }; " +
            "})();" +

            "";
        windowTopHead.appendChild(mainScript);
    }

    window.top.residentStartListeningMain(settings);
}

window.OnGetPage = function OnGetPage(page) {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnGetPage', [page]);
}

window.OnControlReady = function OnControlReady() {
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod('OnControlReady');
}

function ready(callback) {
    if (document.readyState != 'loading') {
        callback();
    } else if (document.addEventListener) {
        document.addEventListener('DOMContentLoaded', callback)
    } else {
        document.attachEvent('onreadystatechange', function () {
            if (document.readyState == 'complete') callback();
        });
    }
}

ready(function () {
    OnControlReady();
});