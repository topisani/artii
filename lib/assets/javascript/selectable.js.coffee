jQuery ($) ->

  element = undefined
  items = undefined
  selected = []
  $.fn.selectable = ( options )->
    settings = $.extend {
      itemClass       : "selectable-item"
      selectedClass   : "selected"
      multiple        : true
    }, options
    element = this
    items = $( element ).find( "." + settings.itemClass )
    items.css("border-radius", "50%")
    select = ( item ) ->
      if ! settings.multiple
        items.removeClass( settings.selectedClass )
      item.addClass( settings.selectedClass )
    deselect = ( item ) ->
      if ! settings.multiple
        items.removeClass( settings.selectedClass )
      item.removeClass( settings.selectedClass )
    toggleSelected = ( item ) ->
      if $( item ).hasClass settings.selectedClass
        deselect item
      else
        select item
    items.bind "click", ->
      console.log "hej"
      toggleSelected( $( this ) )
