# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('#arxiv_linkfile').autocomplete
    source: $('#arxiv_linkfile').data('autocomplete-source');
  $('#arxiv_typefile').autocomplete
    source: $('#arxiv_typefile').data('autocomplete-source');
  $('#mseach').autocomplete
    source: $('#mseach').data('autocomplete-source');
  