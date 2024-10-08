	// This method will return a random number from 0 to max - 1.
	function getRandomInt(max) {
	   return Math.floor(Math.random() * max);
	};

	// This method will display a random quote retrieved from the
	// given url for the passed element id.
	function getQuote(url, elm) {

	  console.debug('GetQuote: Inside getQuote call');
	  let request = new XMLHttpRequest();
	  request.open('GET', url);
	  request.responseType = 'json';
	  request.send();
	  request.onload = () => {

	     console.debug('GetQuote: the request has completed successfully.');

	     // This method will randomly select a quote and then display it
	     const quotes = request.response;
	     const quote = quotes[getRandomInt(quotes.length)];
	     const formatted = quote["formatted"];
	     var div = document.createElement('div');

	     div.setAttribute('style','text-align: left;');
	     div.append(document.createElement('br'));

	     quote.quote.forEach(e => {
	        div.append(e);
		if (formatted) {
		    // This is the case that the quote is really a poem that needs to be written
		    // one a different line.
	            div.append(document.createElement('br'));
		} else {
		    // Add a space at the end to avoid concatinating words together.
	            div.append(' ');
		}
	     });

	     elm.append(div);

	     var div = document.createElement('div');

	     div.setAttribute('style','text-align: right;');
	     div.append(document.createElement('br'));
	     div.append('"');
	     div.append(quote.author);
	     div.append('"');
	     div.append(document.createElement('br'));

	     elm.append(div);

	     console.debug('GetQuote: applied the quote to the web page.');

	   };
	   request.onerror = () => {
	     console.error('GetQuote: An error was received when perform the quotes request.');
	   };
	   request.onabort = () => {
	     console.error('GetQuote: The request was aborted');
	   };
	   request.ontimeout = () => {
	     console.error('GetQuote: The request timed out');
	   };
	   request.onloadstart = () => {
	     console.debug('GetQuote: the request called was started.');
	   };
	   request.onloadend = () => {
	     console.debug('GetQuote: the request called has completed.');
	   };
	   console.debug('GetQuote: Exiting getQuote call');
	};
