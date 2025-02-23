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

			// add an opening quote to the quote
			str = '"'

			quote.quote.forEach((e,idx,arr) => {
				str += e
				if (arr.length != idx + 1) {
					if (formatted) {
						// This is the case that the quote is really a multi-line entry instead of
						// one long entry and needs to be displayed in its own line
						str += "<br/>"
					} else {
						// Add a space at the end to avoid concatenating words together.
						str += ' '
					}
				}
			});

			// add a closing quote to the quote
			str += '"'

			// Parse the generated string from the particular choosen quote
			parsed = new DOMParser().parseFromString(str, "text/html")

			// add all of the generated children nodes to the newly create div element
			for (const entry of parsed.childNodes) {
				div.append(entry)
			}

			elm.append(div);

			var div = document.createElement('div');

			div.setAttribute('style','text-align: right;');
			div.append(document.createElement('br'));
			div.append(quote.author);
			div.append(document.createElement('br'));

			elm.append(div);

			console.debug('GetQuote: applied the quote to the web page.');

		}; // request.onload = () => {
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
