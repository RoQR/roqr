import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['password', 'confirm', 'uppercase', 'lowercase', 'special', 'number', 'length', 'match'];
  static classes = ['good', 'bad'];

  connect() {
    this.uppercase = new RegExp(/[A-Z]/);
    this.lowercase = new RegExp(/[a-z]/);
    this.special = new RegExp(/[^a-z0-9]/i);
    this.number = new RegExp(/[0-9]/);
    this.length = new RegExp(/.{8,}/);
  }

  evaluate() {
    let value = this.passwordTarget.value;
    this.goodClasses.forEach((c) => {
      this.uppercaseTarget.classList.toggle(c, this.uppercase.test(value));
      this.lowercaseTarget.classList.toggle(c, this.lowercase.test(value));
      this.specialTarget.classList.toggle(c, this.special.test(value));
      this.numberTarget.classList.toggle(c, this.number.test(value));
      this.lengthTarget.classList.toggle(c, this.length.test(value));
      this.matchTarget.classList.toggle(c, value === this.confirmTarget.value);
    });
    this.badClasses.forEach((c) => {
      this.uppercaseTarget.classList.toggle(c, !this.uppercase.test(value));
      this.lowercaseTarget.classList.toggle(c, !this.lowercase.test(value));
      this.specialTarget.classList.toggle(c, !this.special.test(value));
      this.numberTarget.classList.toggle(c, !this.number.test(value));
      this.lengthTarget.classList.toggle(c, !this.length.test(value));
      this.matchTarget.classList.toggle(c, value !== this.confirmTarget.value);
    })
  }
}

