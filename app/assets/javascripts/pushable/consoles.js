// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).on('ready page:load', function() {
  $('#console_push_klass').on('change', function() {
    var klass = $(this).val();
     $('.form-group[data-klass] input:not([type="hidden"])').val('');
    $('.form-group[data-klass]').addClass('hide');
    $('.form-group[data-klass="' + klass + '"]').removeClass('hide');
  });
});
