//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require jquery.purr
//= require best_in_place
//= require turbolinks
//= require bootstrap-datepicker
//= require jquery_nested_form
//= require bootstrap-modal
//= require_tree .

function remove_fields(link) {
  $(link).previous("input[type=hidden]").value = "1";
  $(link).up(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).up().insert({
    before: content.replace(regexp, new_id)
  });
}

$(document).ready(function() {
      jQuery(".best_in_place").best_in_place();
    });