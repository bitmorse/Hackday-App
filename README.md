##Nervous Hackday to devise a new third party developer application ecosystem


   * hello-world = example of a JS/HTML app to be submitted to nervous "store"
   * nervousAPI.js = JS interface to phone hardware


### Contributing to  _nervousAPI_ JavaScript
   * run `python -m SimpleHTTPServer` in this directory
   * open `nervousAPI.js` in a text editor (libraries at beginning (minified), new methods below)


### Creating a new app to submit to "store"
   * create a new directory `your-new-app`
   * change into that directory and create `app.js` and `app.html`
   * include 
       `<script type="text/javascript" src="/nervousAPI.js"></script>`
    right before the final `</head>` tag.
   * that's it! now fill you app.js and app.html with beautiful code!
   * (the Nervous JavaScript API is available under the name `Nervous`)


### _nervousAPI_ JavaScript Methods
   * Nervous.getJSAPIVersion()  - returns _nervousAPI_ version