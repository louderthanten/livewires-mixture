# Your javascript goes here
$ ->
    # Make header ampersands fancy
    $('h1:contains("&"),h2:contains("&"),h3:contains("&"),h4:contains("&"),h5:contains("&"),h6:contains("&"),.lead:contains("&"),.content > p:first-child:contains("&")').each ->
        $(@).html($(@).html().replace(/&amp;/, "<abbr class='amp'>&amp;</abbr>"))

    # Wrap inline videos and maps in flexible figures so they are responsive
    $('.content > p > img, .content > p > iframe, .content > p > input').each ->
        $(@).unwrap('p')

    $('.content > iframe').each ->
        source = $(@).attr 'src'
        map = /maps.google/
        isMap = map.test(source)
        if(isMap)
            $(@).wrap '<figure class="map"></figure>'
        else
            $(@).wrap '<figure class="video"></figure>'

    # Wrap inline images in figure tags so they are responsive
    $('.content > img, .content > p > img').wrap '<figure></figure>'

    #Enable responsive video with Fitvids http://fitvidsjs.com/
    $('.video').fitVids()

    # Toggle hidden drawers
    $(document).on 'click', '.js-reveal', (e) ->
        target = $(@).attr 'href'
        $(target).toggleClass 'opened'
        e.preventDefault()

    #Show/hide password fields
    $('.js-show-pw').click (e) ->
        type = $(@).parents('.field').find('input')
        if $(type).attr('type') is 'text'
            $(type).get(0).type = 'password'
            $(@).text 'Show password'
        else
            $(type).get(0).type = 'text'
            $(@).text 'Hide password'
        e.preventDefault()

    #Pill checkbox & radio buttons a little help
    $('.js-options input').change ->
        type = $(@).attr('type')
        check = $(@).parent('label')
        if type is 'checkbox'
            check.toggleClass('checked')
        else if type is 'radio'
            check.siblings('label').removeClass('checked')
            check.addClass('checked')