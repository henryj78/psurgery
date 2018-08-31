// jQuery(function() {
//   return $('#zipcode_zipcode_name').autocomplete({
//     source: ['apple', 'apricot', 'avocado']
//   });
// });

document.addEventListener("turbolinks:load", function() {
    console.log('It works on each visit!');
    jQuery(function() {
      return $('#zipcode_zipcode_name').autocomplete({
        source: $('#zipcode_zipcode_name').data('autocomplete-source')
      });
    });
});
