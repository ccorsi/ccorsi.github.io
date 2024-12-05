// This function will determine if a hash was defined for the passed url instance.
// It will then use that information to highlight the selected item such that you are then able to return to the
// preceeding page by just clicking on the referenced item.  This will allow someone to transverse the reference without
// having to use the back button.
function highlightReference(url) {
   // Determine if the passed url contains a reference to a hash property
   if (url && url.hash) {
      var hash = url.hash.substr(1)
      console.info(`Adding a reference to the original page for hash: [${hash}] to url: ${url.origin}${url.pathname}`)
      // Extract the name of the id that we will be wrapping within an a element
      var olddiv = document.getElementById(hash)
      if (olddiv) {
         // Create a new div that will replace the prior one.
         var newdiv = document.createElement("div")
         // Copy over the attributes from the old div into the new div element
         if (olddiv.attributes) {
            for (const attr of olddiv.attributes) {
               newdiv.setAttribute(attr.name, attr.value)
            } // for (const attr of olddiv.attributes)
         } // if (olddiv.attributes)

         /*
          This is here for history use only since this was the initial implementation
          that was used to be able to go back to the original page using the "a" element

         // Create the required a element to add reference to the prior page.
         var a = document.createElement("a")
         // a.setAttribute("href", url.origin + url.pathname)
         a.setAttribute("onclick", "window.history.back();");
         // Copy innerHTML from olddiv into the newly create a element
         a.innerHTML = olddiv.innerHTML
         // Append the new created a element to the newly create div element
         newdiv.append(a)
         */

         // Create the required "input" element to add reference to the prior page.
         var input = document.createElement("input")
         // Add the required attributes to the "input" element
         input.setAttribute("action","action")
         input.setAttribute("onclick", "window.history.back(); return false;")
         input.setAttribute("type", "submit")
         // Set the value attribute to the inner text of the original "div" element
         input.setAttribute("value", olddiv.innerText)
         // Append the newly created "input" element to the newly create "div" element
         newdiv.append(input)

         // Replace the olddiv with the newdiv
         olddiv.replaceWith(newdiv)
      } // if (olddiv)
   } else {
      console.warn(`The url: ${url} doesn't contain a hash reference`)
   } // if (url && url.hash)
}
