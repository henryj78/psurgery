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

    // navigator.geolocation.getCurrentPosition( function (position) {
    //       var latitude		= position.coords.latitude;
    //       var longitude	  = position.coords.longitude;
    //       var array = [latitude, longitude];
    //       console.log('I am in geolocation')
    //       console.log(latitude)
    //       console.log(longitude)


          //plced in hidden text field
          //$(document).ready(function(){
            //$("#zipcode_latitude").val(latitude);
            //$("#zipcode_longitude").val(longitude);
            // var array = ['r', 't'];
            // $.ajax({
            //         url : "/zipcode_customer",
            //         type : "get",
            //         data : { data_value: JSON.stringify(array) }
            //     });
            //});
        //});
    //
    //         navigator.permissions.query({name:'geolocation'}).then(function(result) {
    //           var permission = result.state
    //           if (permission == 'granted' ){
    //             console.log("Call method")
    //           }
    //           console.log( permission )
    //         });
    //
    //         if (navigator && navigator.geolocation) {
    //                 console.log('Bowser is supported')
    //                }else {
    //                 console.log('Geolocation is not supported');
    //               }

      //$('form')[0].submit()
});
