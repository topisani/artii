# #= require cropper/dist/cropper.min
# $('.modal').on 'show.bs.modal', ->
#   currentDialog = $('.modal-dialog:visible')
#   targetDialog = $(this).first('.modal-dialog')
#   if !currentDialog.length
#     return
#   targetDialog.data 'previous-dialog', currentDialog
#   currentDialog.addClass 'aside'
#   stackedDialogCount = $('.modal.in .modal-dialog.aside').length
#   #if stackedDialogCount <= 5
#     #currentDialog.addClass 'aside-' + stackedDialogCount
#   return
# $('.modal').on 'hide.bs.modal', ->
#   $dialog = $(this)
#   previousDialog = $dialog.data('previous-dialog')
#   if previousDialog
#     previousDialog.removeClass 'aside'
#     $dialog.data 'previous-dialog', undefined
#   return
