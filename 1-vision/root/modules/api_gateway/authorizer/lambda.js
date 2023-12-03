module.exports.handler =  function(event, context, callback) {
  console.log(event, context, callback)
    var token = event.headers['Authorization'];
    switch (token) {
        case 'allow':
            callback(null, generatePolicy(true));
            break;
        case 'deny':
            callback(null, generatePolicy(false));
            break;
        case 'unauthorized':
            callback("Unauthorized");   // Return a 401 Unauthorized response
            break;
        default:
            callback("Error: Invalid token"); // Return a 500 Invalid token response
    }
};

// Help function to generate an IAM policy
var generatePolicy = function(allow) {
    var authResponse = {isAuthorized: allow};
    

    return authResponse;
}