import { ASAP, fixLayout, preload } from '/site/common/js/utils.coffee'

fixLayout()

$scrolltoReady = null
showHodelBlockByIdx = ($blocks, idx, do_scroll = no) ->
    $block_shown = null
    $blocks.each (i, block) ->
        op = if idx == i then 'show' else 'hide'
        $block_shown = $(block) if op == 'show'
        $(block)[op]()
    if do_scroll
        $.when($scrolltoReady).done ->
            $(window).scrollTo $block_shown, 500, offset: -150

ASAP ->

    $scrolltoReady = $.Deferred()
    preload 'https://cdnjs.cloudflare.com/ajax/libs/jquery-scrollTo/2.1.3/jquery.scrollTo.min.js', -> $scrolltoReady.resolve()

    $hotel_blocks = $('.code2me-hotels-set[data-component-instance]')
    $(document).on 'click', '.nav-filter-grid > button', (e) ->
        showHodelBlockByIdx $hotel_blocks, $(this).index(), 'do-scroll'

    showHodelBlockByIdx $hotel_blocks, 0
