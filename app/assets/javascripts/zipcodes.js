// jQuery(function() {
//   return $('#zipcode_zipcode_name').autocomplete({
//     source: ['apple', 'apricot', 'avocado']
//   });
// });

document.addEventListener("turbolinks:load", function() {
    console.log('loading counties name - zipcodes.js');
    jQuery(function() {
      return $('#zipcode_zipcode_name').autocomplete({
        source: $('#zipcode_zipcode_name').data('autocomplete-source')
      });
    });

    // navigator.geolocation.getCurrentPosition( function (position) {
    //       var latitude		= position.coords.latitude;
    //       var longitude	  = position.coords.longitude;
    //       var array = [latitude, longitude];
    //
    //             navigator.permissions.query({name:'geolocation'}).then(function(result) {
    //               var permission = result.state
    //                 if (permission == 'granted') {
    //                   console.log(permission);
    //                   //$('form')[0].submit()
    //                 }
    //               });
    //
    //        $(document).ready(function(){
    //          $("#zipcode_latitude").val(latitude);
    //          $("#zipcode_longitude").val(longitude);
    //        });
    //     });
});

// navigator.geolocation.watchPosition(function(position) {
//   console.log("permissions were granted");
// },
// function (error) {
//   if (error.code == error.PERMISSION_DENIED)
//       console.log("you denied me :-(");
//  });
