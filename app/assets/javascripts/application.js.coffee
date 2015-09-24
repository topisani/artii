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
#= require jquery
#= require jquery_ujs
#= require turbolinks
#= require bootstrap-sprockets
#= require dropzone
#= require image-picker
#= require masonry
#= require_tree .

ready = ->
  # disable auto discover
  Dropzone.autoDiscover = false
  dropzone = new Dropzone('.dropzone',
    maxFilesize: 256
    paramName: 'picture[image]'
    addRemoveLinks: false)

  dropzone.on 'success', (file) ->
    @removeFile file
    $.getScript '/pictures'
    $(".image-picker").data('picker').sync_picker_with_select

  $( ".image-picker" ).imagepicker()

$(document).ready(ready)
$(document).on('page:load', ready)
