// This method will display a random image retrieved from the
// given url for the passed element id.
function getImage(url, elm) {

	console.debug('GetImage: Inside getImage call');
	let request = new XMLHttpRequest();
	request.open('GET', url);
	request.responseType = 'json';
	request.send();
	request.onload = () => {

		console.debug('GetImage: the request has completed successfully.');

		// This method will randomly select a image and then display it
		const images = request.response;
		const image = images[Math.floor(Math.random() * images.length)];

		console.debug(`Updating element: ${elm}`)
		console.debug(`element class name: ${elm.className}`)

		for (idx = 0 ; idx < elm.attributes.length ; idx++) {
			console.debug(`element ${idx} attribute: ${elm.attributes[idx].name} = ${elm.attributes[idx].value}`)
		}

		console.debug(`updating style attribute to using image: ${image}`)

		elm.setAttribute('style', `background-image: url("${image}")`)

		console.debug('GetImage: applied the image to the web page.');

	}; // request.onload = () => {
	request.onerror = () => {
		console.error('GetImage: An error was received when perform the images request.');
	};
	request.onabort = () => {
		console.error('GetImage: The request was aborted');
	};
	request.ontimeout = () => {
		console.error('GetImage: The request timed out');
	};
	request.onloadstart = () => {
		console.debug('GetImage: the request called was started.');
	};
	request.onloadend = () => {
		console.debug('GetImage: the request called has completed.');
	};
	console.debug('GetImage: Exiting getImage call');
};
