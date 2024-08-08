/*
File: loads.js
Description:
*/

function loadJS(source, type = 'application/javascript') {
    // Create a script DOM element
    var jsElement = document.createElement('script');
    // set the type attribute
    jsElement.type = type;
    // set the src attribute
    jsElement.src = source;
    // append the defined javascript to the documents body element for it to be loaded
    document.body.appendChild(jsElement);
}
