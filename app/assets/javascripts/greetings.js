// navigator.geolocation.getCurrentPosition( function (position) {
//       var latitude		= position.coords.latitude;
//       var longitude	  = position.coords.longitude;
//
//       navigator.permissions.query({name:'geolocation'}).then(function(result) {
//         var permission = result.state
//           $("#greeting_permission").val(permission);
//           if (permission == 'granted') {
//             $('form')[0].submit()
//           }
//         });
//
//
//       //plced in hidden text field
//       $(document).ready(function(){
//          $("#greeting_latitude").val(latitude);
//          $("#greeting_longitude").val(longitude);
//         });
//     });
