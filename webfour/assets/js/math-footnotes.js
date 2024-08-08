---
---
// <!-- 
//  this handles the automatic mathematical footnotes generation.
//  -->
$( document ).ready(function() {
    console.debug('Inside Mathematical Footnotes ready callback');
 
    // let minimum = {{ page.footnotes.minimum | default: site.footnotes.minimum | default: 10000 }}
    let minimum = {{ page.footnotes.minimum | default: site.footnotes.minimum | default: 10000 }}

    let math = document.getElementById("math")

    console.debug(`math element length: ${math.innerText.length} required minimum: ${minimum}`)

    if (math.innerText.length < minimum) {
        // disable the footnotes
        let footnotes = document.getElementById( "math-footnotes" )
        footnotes.parentElement.removeChild( footnotes )
        return
    }

    // Process all types of mathematical types
    const values = [['definition', 'def'], ['theorem', 'thrm'], ['proposition', 'prop'] ];

    $.each( values, (_, [name, prefix]) => {
        $.each( $( `[id=${name}]` ), (_, elem) => {
            updateIdFor(name, elem, prefix);
        });
    })

    console.debug('Completed Mathematical Footnotes changes')
 });

function updateIdFor(name, elem, prefix) {
    console.debug(`Updating mathematical for id ${name}`)

    let header = elem.querySelector(`[id=${name}-header]`)

    if (header) {
        // the header id exists for the passed name thus update its id
        const value = `${name}-` + header.getAttribute(name),
        msg = ` forid: ${header.getAttribute('id')}`,
        attr = `${name}-value`;

        console.debug(`Setting ${attr} to ${value}${msg}`)
        header.setAttribute(attr, value)
        header.setAttribute('id', value)
        console.debug(`Set ${attr} to ${value}${msg}`)

        // check if the text id exists for the passed name
        let text = elem.querySelector(`[id=${name}-text]`)

        if (text) {
            let footnotes = document.querySelector( "div[id='math-footnotes']" )
            if (footnotes) {
                let footnote = document.createElement("div");
                let sup = document.createElement('sup')
                let a = document.createElement('a')
                a.setAttribute('href', `#${value}`)
                a.appendChild( document.createTextNode( `${prefix}-${header.getAttribute(name)}` ) )
                sup.appendChild( a )
                footnote.appendChild( sup )
                footnote.appendChild( document.createTextNode( ' ') )
                const max = {{ page.footnotes.length | default: site.footnotes.length | default: 40 }};
                // console.debug('######################## PRINT NODE START #######################')
                // printNode( text )
                // console.debug('######################## PRINT NODE END #######################')
                console.debug('######################## ADD CHILDREN OF NODE START #######################')
                if (text.innerText?.length < max) {
                    // console.debug(`******************** cloning top-level node: ${text}`)
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
                console.debug('######################## ADD CHILDREN OF NODE END #######################')
                footnotes.appendChild( footnote )    
            }
        }
    }

    console.debug(`Updated mathematical for id ${name}`)
}

function addChildrenOf( footnote, elem, cur, max ) {
    console.debug(`addChildrenOf: cur: ${cur} max: ${max} element: ${elem}`)
    if (elem.nodeType == 1) {
        if (elem.innerText.length + cur < max) {
            cur = cur + elem.innerText.length
            footnote.appendChild( elem.cloneNode( true ) )
            console.debug(`1 - cloned element done`)
            return cur
        } else {
            console.debug(`element text exceed max: ${max}`)
            let top = document.createElement(elem.nodeName);
            footnote.appendChild( top )
            // A sub-set of the currently passed element will be added to the passed footnote
            for (const child of elem.children) {
                console.debug(`2 - processing child type: ${child.nodeType} node: ${child}`)
                switch ( child.nodeType ) {
                    case 1: // ELEMENT NODE
                        console.debug(`child innerText: ${child.innerText}`)
                        if ( ! child.innerText ) {
                            console.debug(`3.0 - appending child element: ${child}`)
                            top.appendChild( child.cloneNode( true ) )
                        } else if (cur + child.innerText.length < max) {
                            console.debug(`3 - appending child element: ${child}`)
                            top.appendChild( child.cloneNode( true ) )
                            cur = cur + child.innerText.length
                        } else {
                            return addChildrenOf( top, child, cur, max)
                        }
                        break
                    case 3: // TEXT NODE
                        if ( cur + child.data.length < max) {
                            console.debug(`4 - appending child text: ${child}`)
                            top.appendChild( child.cloneNode( true ) )
                            cur = cur + child.data.length
                        } else {
                            return addChildrenOf( top, child, cur, max)
                        }
                    break;
                    default:
                        console.debug(`5 - OOPS: I am not processing node ${child} of type: ${child.nodeType }`)
                        top.appendChild( child.cloneNode( true ) )
                    break
                }
            }
            return max
        }
    } else if (elem.nodeType == 3) {
        if (elem.data.length + cur < max) {
            console.debug(`6 - appending cloned node text: ${elem}`)
            cur = cur + elem.data.length
            footnote.appendChild( elem.cloneNode( true ) )
            return cur
        } else {
            console.debug(`7 - appending substr of node text: ${elem}`)
            const len = max - cur - 3;
            footnote.appendChild(
                document.createTextNode( `${elem.data.substr(0,len)}...`)
            )
            return max
        }
    }
    // nothing was added therefore return cur
    return cur
}

function printNode( node, prefix = "" ) {
    console.debug(`${prefix}Processing node name: ${node.nodeName} type: ${node.nodeType}`)
    switch( node.nodeType ) {
        case 1: // ELEMENT NODE
            if (node.innerText) console.debug(`${prefix}innerText: ${node.innerText}`)
            for (const child of node.childNodes) {
                // console.debug(child)
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
 