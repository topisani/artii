/* Two required variables */
$.fn.api.settings.api = {
  'login' : '/login?username_or_email={username_or_email}&password={password}',
};

// Responses without this status will trigger error conditions
$.fn.api.settings.successTest = function(response) {
  return response.status == 'OK';
}
