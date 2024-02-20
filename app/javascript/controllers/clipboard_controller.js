import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["source", "trigger"];

  copy(event) {
    event.preventDefault();
    navigator.clipboard.writeText(this.sourceTarget.value);

    this.sourceTarget.focus();
    var triggerElement = this.triggerTarget;
    var initialHTML = triggerElement.innerHTML;
    triggerElement.innerHTML = "<svg xmlns='http://www.w3.org/2000/svg' fill='none' viewBox='0 0 24 24' stroke='currentColor' class='w-6 h-6'><path stroke-linecap='round' stroke-linejoin='round' stroke-width='2' d='M5 13l4 4L19 7'/></svg>";

    setTimeout(() => {
      triggerElement.innerHTML = initialHTML;
      // unfocus
      this.sourceTarget.blur();
    }, 2000);
  }
}


