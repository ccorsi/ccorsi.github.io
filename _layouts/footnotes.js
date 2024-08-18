---
layout: none
---
{% comment %}

   The following provides a framework that can be used to create different javascript
   script that can be used add footnotes to a given page.

   The user will be require to define the following page attributes:

   	type: What type of footnotes is this, example Mathematical
	id: The element id associated with the math element that contain the footnotes
	values: An array of an array of size two that contains the elements to use as footnotes
	length: The amount of text that will displayed in the footnote, default 40
	minimum: The minimum amount of text that needs to be part of the page to generate footnotes, default 10000
	debug: If you want to include tracing information for debugging purposes, set it to true
	printNode: If you want to log the current Element being processed, set it to true

    For example,

    type: Mathematical
    id: math
    values: [ [ 'definition', 'def' ], [ 'theorem', 'thrm'], ['proposition', 'prop'] ]
    minimum: 10000
    length: 50
    debug: true
    printNode: true

{% endcomment -%}
{% assign footnotes = site.data.config.footnotes[page.id] -%}
// <!-- 
//  This code is automatically generated using the footnotes.html layout.
//  This handles the automatic {{ page.type }} footnotes generation.
//  -->
$( document ).ready(function() {
    console.info('Inside {{ page.type }} Footnotes ready callback');
 
    let minimum = {{ page.minimum | default: footnotes.minimum | default: site.footnotes.minimum | default: 10000 }}

    let {{ page.id }} = document.getElementById("{{ page.id }}")

    if ( {{ page.id }}) {
        console.info(`{{ page.id }} element length: ${ {{ page.id }}.innerText.length } requires minimum length: ${minimum}`)

        if ({{ page.id }}.innerText.length < minimum) {
		{% comment %}
		NOTE: The following javascript code is not required any longer since the 
		div with the given id is not being added to the page.
            // disable the footnotes
            let footnotes = document.getElementById( "{{ page.id }}-footnotes" )
            footnotes.parentElement.removeChild( footnotes )
		{% endcomment %}
            {% if page.debug %}console.debug('The minimum length of the page was not reached so footnotes will not be included.'){% endif %}
        } else {
            // Process all types of {{ page.type }} types
            const values = [ {% for value in page.values %} [ '{{ value[0] }}', '{{ value[1] }}' ], {% endfor -%} ];

            $.each( values, (_, [name, prefix]) => {
                $.each( $( `[id=${name}]` ), (_, elem) => {
                    {% if page.printNode %}printNode(elem){% endif %}
                    updateIdFor(name, elem, prefix);
                });
            })

            // Determine if any footnotes were found during the prior search.
            let footnotes = document.getElementById( "{{ page.id }}-footnotes" )
            if ( footnotes.childElementCount > 0) {
                // Add the footnote separation
                let hr = document.createElement( "hr" )
                {{ page.id }}.firstElementChild.before(hr)
                {% if page.debug %}console.debug('Footnotes were created thus adding footnotes separator to page.'){% endif %}
            }
        }
    }

    console.info('Completed {{ page.type }} Footnotes changes')
 });

function updateIdFor(name, elem, prefix) {
    console.info(`Updating {{ page.type }} for id ${name}`)

    let header = elem.querySelector(`[id=${name}-header]`)

    if (header) {
        // the header id exists for the passed name thus update its id
        const value = `${name}-` + header.getAttribute(name),
        msg = ` forid: ${header.getAttribute('id')}`,
        attr = `${name}-value`;

	    {% if page.debug %}console.debug(`Setting ${attr} to ${value}${msg}`){% endif %}
        header.setAttribute(attr, value)
        header.setAttribute('id', value)
	    {% if page.debug %}console.debug(`Set ${attr} to ${value}${msg}`){% endif %}

        // check if the text id exists for the passed name
        let text = elem.querySelector(`[id=${name}-text]`)

        if (text) {
	        let footnotes = document.querySelector( "div[id='{{ page.id }}-footnotes']" )
            if (footnotes) {
                let footnote = document.createElement("div");
                let sup = document.createElement('sup')
                let a = document.createElement('a')
                a.setAttribute('href', `#${value}`)
                a.appendChild( document.createTextNode( `${prefix}-${header.getAttribute(name)}` ) )
                sup.appendChild( a )
                footnote.appendChild( sup )
                footnote.appendChild( document.createTextNode(' ') )
                const max = {{ page.footnotes.length | default: footnotes.length | default: site.footnotes.length | default: 40 }};
                if (text.innerText?.length < max) {
                    for (const child of text.childNodes) {
                        // Append each child to the current footnote node
                        footnote.appendChild( child.cloneNode( true ) )
                    }
                } else {
                    let cur = 0;
                    for (const child of text.childNodes) {
                        cur = addChildrenOf( footnote, child, cur, max)
                        if (cur >= max) break
                    }
                }
                footnotes.appendChild( footnote )    
            }{% if page.debug %} else {
                console.debug('No child elements for div element were found for id={{ page.id }}-footnotes')
            }{% endif %}
        }{% if page.debug %} else {
            console.debug(`No elements were found for id=${name}-text`)
        }{% endif %}
    }

    console.info(`Updated {{ page.type }} for id ${name}`)
}

function addChildrenOf( footnote, elem, cur, max ) {
    {% if page.debug %}console.debug(`Processing children with current length: ${cur} with max: ${max} for element: ${elem}`){% endif %}
    if (elem.nodeType == 1) {
        if (elem.innerText.length + cur < max) {
            cur = cur + elem.innerText.length
            footnote.appendChild( elem.cloneNode( true ) )
            {% if page.debug %}console.debug(`appended cloned element: ${elem}`){% endif %}
            return cur
        } else {
            {% if page.debug %}console.debug(`element text exceed max: ${max}`){% endif %}
            let top = document.createElement(elem.nodeName);
            footnote.appendChild( top )
            // A sub-set of the currently passed element will be added to the passed footnote
            for (const child of elem.children) {
                {% if page.debug %}console.debug(`processing child type: ${child.nodeType} node: ${child}`){% endif %}
                switch ( child.nodeType ) {
                    case 1: // ELEMENT NODE
                        {% if page.debug %}console.debug(`child element innerText: ${child.innerText}`){% endif %}
                        if ( ! child.innerText ) {
                            {% if page.debug %}console.debug(`appending child element: ${child} without innerText`){% endif %}
                            top.appendChild( child.cloneNode( true ) )
                        } else if (cur + child.innerText.length <= max) {
                            {% if page.debug %}console.debug(`appending child element: ${child} with innerText`){% endif %}
                            top.appendChild( child.cloneNode( true ) )
                            cur = cur + child.innerText.length
                        } else {
                            {% if page.debug %}console.debug(`child innerText length and current element length: ${cur + child.innerText.length} exceeds max: ${max}`){% endif %}
                            return addChildrenOf( top, child, cur, max)
                        }
                        break
                    case 3: // TEXT NODE
                        if ( cur + child.data.length <= max) {
                            {% if page.debug %}console.debug(`appending child text node: ${child}`){% endif %}
                            top.appendChild( child.cloneNode( true ) )
                            cur = cur + child.data.length
                        } else {
                            {% if page.debug %}console.debug(`child text node length and current element length: ${cur + child.data.length} exceeds max: ${max}`){% endif %}
                            return addChildrenOf( top, child, cur, max)
                        }
                    break;
                    default:
                        console.warn(`Don't know how to process node ${child} of type: ${child.nodeType }`)
                        top.appendChild( child.cloneNode( true ) )
                    break
                }
            }
            return max
        }
    } else if (elem.nodeType == 3) {
        if (elem.data.length + cur < max) {
            {% if page.debug %}console.debug(`appending cloned text node: ${elem}`){% endif %}
            cur = cur + elem.data.length
            footnote.appendChild( elem.cloneNode( true ) )
            return cur
        } else {
            {% if page.debug %}console.debug(`appending truncated text node: ${elem}`){% endif %}
            const len = max - cur - 3;
            footnote.appendChild(
                document.createTextNode( `${elem.data.substr(0,len)}...`)
            )
            return max
        }
    }
    console.warn(`Unable to append child for element: ${elem} with unknown name/type: [${elem.nodeName}, ${elem.nodeType}]`)
    // nothing was added therefore return cur
    return cur
}

function printNode( node, prefix = "" ) {
    console.debug(`${prefix}Processing node name: ${node.nodeName} type: ${node.nodeType}`)
    switch( node.nodeType ) {
        case 1: // ELEMENT NODE
            if (node.innerText) console.debug(`${prefix}innerText: ${node.innerText}`)
            for (const child of node.childNodes) {
                printNode( child, `${prefix}\t`)
            }
        break
        case 2: // ATTRIBUTE_NODE
            console.debug(`${prefix}attribute: ${node.name}`)
        break
        case 3: // TEXT_NODE
            console.debug(`${prefix}text: ${node.data}`)
        break
        case 4: // CDATA_SECTION_NODE
            console.debug(`${prefix}cdata section: ${node.data}`)
        break
        case 7: // PROCESSING_INSTRUCTION_NODE
            console.debug(`${prefix}processing instruction: ${node.data}`)
        break
        case 8: // COMMENT_NODE
            console.debug(`${prefix}comment: ${node.data}`)
        break
        case 9: // DOCUMENT_NODE
            console.debug(`${prefix}node:`)
        break
        case 10: // DOCUMENT_TYPE_NODE
            console.debug(`${prefix}node type:`)
        break
        case 11: // DOCUMENT_FRAGMENT_NODE
            console.debug(`${prefix}fragment node:`)
        break
        default:
            console.debug(`${prefix}UNDEFINED NODE TYPE: ${node.nodeType}`)
        break
    }
}
 // Copyright 2024 Claudio Corsi
 
