---
---
// <!-- 
//  this handles the automatic toc. use ## for subheads to auto-generate the
//  on-page minitoc. if you use html tags, you must supply an ID for the heading
//  element in order for it to appear in the minitoc.
//  -->
$( document ).ready(function() {
   console.debug('TOC: Inside Table of Content ready callback');
  // Handler for .ready() called.

  try {
     $('#toc').toc({
       minimumHeaders: {{ site.minimumHeaders | default: 0 }},
       listType: 'ul',
       showSpeed: 0,
       headers: 'h2,h3,h4'
     });

     /* determine if there are any enteries that will be used to create a Table of Content */
     if ( $( '#toc' ).children().first().length > 0 ) {
        /* Add a Table of Content Heading */
        $( '#toc' ).children().first().prepend( $( "<h2>" ).append( $( "<u>" ).text('Table of Content') ).css("text-align", "center") )
        $( '#toc' ).children().first().append( $( "<hr>" ) )
        console.debug('TOC: Added a Table Of Content')
     }

     /* this offset helps account for the space taken up by the floating toolbar. */
     $('#toc').on('click', 'a', function() {
       var target = $(this.getAttribute('href')),
         scroll_target = target.offset().top

       $(window).scrollTop(scroll_target - 10);

       return false
     })
  } catch (exc) {
     console.debug(`TOC: An exception was raised while processing Table of Context: ${exc}`)
  } finally {
     console.debug('TOC: Exiting Table of Content ready callback');
  }
});
// Copyright 2021 Google LLC
// Copyright 2024 Claudio Corsi
