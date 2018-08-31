document.addEventListener("turbolinks:load", function() {
    console.log('It works on each visit! to county');
    jQuery(function() {
      var counties;
      counties = $('#customer_zone_id').html();
       console.log(counties);
      return $('#customer_state_id').change(function() {
        var state, options;
        state = $('#customer_state_id :selected').text();
        options = $(counties).filter("optgroup[label=" + state + "]").html();
        console.log(options);
        if (options) {
          return $('#customer_zone_id').html(options);
        } else {
          return $('#customer_zone_id').empty();
        }
      });
    });
});
