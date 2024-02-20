// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


function disableSubmitButton() {
  // Disable the submit button
  document.getElementById('submitBtn').disabled = true;

  // Optionally, you can display a loading indicator
  // Example: document.getElementById('loadingIndicator').style.display = 'block';

  // Submit the form
  document.getElementById('urlForm').submit();
}

disableSubmitButton()