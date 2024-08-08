/**
 * utils.js
 */

/**
 * This method will add attributes to the passed node.
 * 
 * @param {Node} node The node that attributes will be added too
 * @param {Object} attributes Instance containing attributes to be added to the passed Node
 * @returns The passed node so that you can chain
 */
export function add_attributes(node, attributes) {
    for(const attr in attributes) {
        // check that the attribute wasn't already defined
        if (node[attr] == undefined) {
            node[attr] = attributes[attr]
        } else {
            node[attr] = node[attr] + " " + attributes[attr]
        }
    }
    return node
}

export function create_node(parent, name, options = {}) {
    parent.append(add_attributes(document.createElement(name), options))
    return parent
}