# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require semanticApi
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require semantic.min
#= require dropzone
#= require image-picker
#= require slick-carousel/slick/slick.min

ready = ->

###############################
# Utility Functions
###############################
  window.executeFunctionByName = (functionName, context ) ->
    args = [].slice.call(arguments).splice(2)
    namespaces = functionName.split(".")
    func = namespaces.pop()
    for namespace in namespaces
      context = context[namespace]
    return context[func].apply(this, args);
#################################
# SemanticUI Activators
#################################

  $('.ui.modal').modal()
  $('.dropdown').dropdown()
  $('.no.action.dropdown').dropdown(
    action: "nothing"
  )
  $('.card .dimmable').dimmer
    on: 'hover'

#################################
# HTML5 Data attributes
#################################
## Open modal with unobtrusive javascript
  $('[data-open-modal]').click ->
    $("#" + $(this).data("open-modal")).modal("show")

## Create slick carousel with pictures
  $('.slick[data-slick]').each ->
    pictures = $(this).data('slick').split(',')
    version = if $(this).data('img-version') then "_" + $(this).data('img-version') else ""
    for picture in pictures
      $(this).append "
        <div class='slick-item'>
          <img class='ui image' src='/pictures/" + picture + version + ".jpg'/>
        </div>
        "
    $(this).slick(
      dots: true
      infinite: true
      speed: 2000
      slidesToShow: 1
      centerMode: true
      slidesToScroll: 1
      autoplay: true
      autoplaySpeed: 2000
      fade: false
      cssEase: 'ease'
      pauseOnHover: false
      variableWidth: true
    )
## Hide image overflow
  $('.image[data-src]').each ->
    $(this).css("background-image", "url('" + $(this).data("src") + "')")

#################################
# Rails AJAX
#################################

## Make form buttons show the loading loader thingy when loading:
  $("form[data-remote]").on("ajax:begin", (e) ->
    $(this).find("button:submit").addClass("loading");
  ).on( "ajax:done", (e) ->
    $(this).find("button:submit").removeClass("loading");
  )
## Specifics for the Login form:
  $("form[data-remote].loginform").on("ajax:success", (e, data, status, xhr) ->
    $(this).find("button:submit").addClass("success");
    location.reload();
  )

#################################
# Image Picker
#################################

  window.openPictureSettings = ->
    picker = $( "#image-picker-form ")
    id = picker.find( "div.current").data( "option-value" )
    current = $(picker.find( ".current" ))
    other_items = $(picker.find( ".image-picker-item:not(.current)" ))
    picker.find('#image-cropper')

  window.loadPictureSettings = ->
    id = $("#image-picker-form div.current").data( "option-value" )
    element = $( "#image-picker-form .current .picture-settings" )
    element.load( "/pictures/" + id + "/edit" )
    $('#picture_image_cropbox').attr("src", "/uploads/users/" + window._user_id + "/picture/" + id + "/p1000_img.jpg")

  window.setUserAvatar = (data) ->
    $.ajax({
      type: 'patch',
      dataType:'json',
      data: "?authenticity_token=" + window._token + "&user[avatar_id]=" + data[0]
      url:'/users/' + window._user_id + '.json'
    })
  window.setUserCover = (data) ->
    $.ajax({
      type: 'patch',
      dataType:'json',
      data: "?authenticity_token=" + window._token + "&user[cover_picture_id]=" + data[0]
      url:'/users/' + window._user_id + '.json'
    })
  window.reloadPickerContents = ->
    $( "select.image-picker" ).html("")
    $( "select.image-picker" ).load( "/settings" + " select.image-picker option", ->
      $( ".image-picker" ).data('picker').sync_picker_with_select()
      $( "select.image-picker" ).imagepicker
        show_label: true
    )
  $('[data-image-picker]').click ->
    button = $(this)
    button.addClass("loading")
    button.parent().append('<div class="tmp" id="image-picker" />')
    $('.tmp#image-picker').load( "/pictures/picker #picture-selector", ->
      $( "select.image-picker" ).imagepicker
        show_label: true
        multiple: button.data("multiple")
      button.removeClass("loading")
      $('.tmp#image-picker .modal#picture-selector').modal(
        onHidden: ->
          $('.tmp#image-picker').remove()
        onApprove: (element) ->
          data = []
          $(this).find("select.image-picker option:selected").each( ->
            data.push $(this).val()
          )
          window.executeFunctionByName(button.data("image-picker"),window, data)
      ).modal('show')
    )




$(document).ready ready
$(document).on 'page:load', ready
