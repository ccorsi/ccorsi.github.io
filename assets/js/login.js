
// Function to log in with email/password
export function login() {
    const email = document.getElementById("email").value;
    const password = document.getElementById("password").value;

    // Check if the user has already been login.
    if (firebase.auth().currentUser) {
        // The current user is still logged in
        const user = firebase.auth().currentUser.user;
        console.log(`The user '${user.email}' is still logged in with user id: ${user.uid}`)
        uid = user.uid
        // Insure that all of the require elements are displayed and hidden correctly.
        document.getElementById("login").style.display = "none";
        document.getElementById("logout").style.display = displays.logout; // logout_display;
        document.getElementById("email").value = "";
        document.getElementById("password").value = "";
    } else {
        firebase.auth().signInWithEmailAndPassword(email, password)
        .then((userCredential) => {
            // Login successful
            const user = userCredential.user;
            console.log("Logged in as:", user.email);
            console.log("User id:", user.uid);
            uid = user.uid;
            // You can perform further actions here, such as redirecting to another page.
            // We need to disable the current login element within the web page
            database = firebase.database();
            database.ref("groceries/users/" + uid).set({
                name: "Claudio",
                email: user.email
            });
            console.log("Created an entry within the Firebase Realtime Database");
            document.getElementById("login").style.display = "none";
            document.getElementById("logout").style.display = displays.logout; // logout_display;
            document.getElementById("email").value = "";
            document.getElementById("password").value = "";
        })
        .catch((error) => {
            // Login error
            const errorMessage = error.message;
            console.error("Login error:", errorMessage);
            const lookfor = '(auth/';
            if (errorMessage.includes(lookfor)) {
                const start = errorMessage.indexOf(lookfor) + lookfor.length;
                const end = errorMessage.indexOf(')', start);
                const errorCode = errorMessage.substring(start, end);
                console.debug(`start=${start}, end=${end}, code=${errorCode}`);
                switch (errorCode) {
                    case 'invalid-email':
                    case 'missing-password':
                    case 'user-not-found':
                        alert('Incorrect username/password entered, try again');
                        break;
                    default:
                        alert(`An issue was encountered when logging in: ${errorMessage}`);
                    }
            }
        });
    }
}

// Function to logout of the current firebase session
export function logout() {
    // Check if the user has already been login.
    if (firebase.auth().currentUser) {
        console.log('User is already login', firebase.auth().currentUser);
        firebase.auth().signOut();
        // reset the page to include the login prompt and hide the logout page
        let div = document.getElementById("login");
        div.style.display = displays.login; // login_display;
        div = document.getElementById("logout");
        div.style.display = "none";
    }
}

export function setup() {
    console.log("The web page was loaded");
    let div = document.getElementById("logout");
    displays.logout = logout_display = div.style.display;
    // hide the logout button
    div.style.display = "none";
    div = document.getElementById("login");
    displays.login = login_display = div.style.display;
    divs.forEach((name) => {
        const div = document.getElementById(name);
        // Determine the current display setting and store it and then make the current display to none.
        displays[name] = div.style.display;
        div.style.display = "none";
    });
    console.log("completed setting up of web page");
}

// Initialize Firebase Configuration
const firebaseConfig = {
    apiKey: "AIzaSyAl7ILFJfXRqkcNM-GXfCch6trpB9_DKuI",
    databaseURL: "https://books-45547-default-rtdb.firebaseio.com",
    authDomain: "YOUR_AUTH_DOMAIN", // I don't need this information to log onto my books firebase realtime database
    projectId: "books-45547",
    storageBucket: "YOUR_STORAGE_BUCKET", // I don't need this to work with my firebase realtime database
    appId: "YOUR_APP_ID" // this is also not required to be logged to my firebase realtime database
};

// Initialize the Firebase Connection with the above configuration settings
firebase.initializeApp(firebaseConfig);

let uid = undefined;
let database = undefined;
let login_display = undefined;
let logout_display = undefined;
let displays = {
    "login": undefined,
    "logout":  undefined,
    "visible": undefined
};

// This contains the id of the different div elements used to process input data
let divs = [
    "store", "department", "brand", "product", "groceries"
];

function add(type) {
    console.log(`Received ${type} action`);
    if (displays[type]) {
        console.log(`Processing ${type} action`);
        display(type);
    } else {
        console.log('Unknown action:', type);
    }
}

// This function will display passed element id and disable currently visible element
function display(id) {
    if (displays.visible == undefined || displays.visible != id) {
        // Hide the currently visible entry
        document.getElementById(displays.visible).style.display = "none";
    }
    document.getElementById(id).style.display = displays[id];
    displays.visible = id;
    if (id == 'groceries') {
        // We need to populate the selection elements with the required data that
        // was available within the Firebase Realtime Database.
    }
}

// This function is not really required since there isn't much more typing required to get the same result.
function get_value_by_id(id) {
    return document.getElementById(id)?.value;
}

var name = "webfcns";
var version = "0.0.1";
var global_var = undefined

if (typeof self !== 'undefined') {
    global_var = self
} else if (typeof window !== 'undefined') {
    global_var = window
} else if (typeof global !== 'undefined') {
    global_var = global
}

if (global_var !== 'undefined') {
    global_var.setup  = setup
    global_var.login  = login
    global_var.logout = logout
} else {
    throw new Error('Unable to locate global variable object');
}
