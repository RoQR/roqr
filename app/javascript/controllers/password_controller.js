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
    this.uppercaseTarget.classList.toggle(this.badClass, !this.uppercase.test(value));
    this.uppercaseTarget.classList.toggle(this.goodClass, this.uppercase.test(value));
    this.lowercaseTarget.classList.toggle(this.badClass, !this.lowercase.test(value));
    this.lowercaseTarget.classList.toggle(this.goodClass, this.lowercase.test(value));
    this.specialTarget.classList.toggle(this.badClass, !this.special.test(value));
    this.specialTarget.classList.toggle(this.goodClass, this.special.test(value));
    this.numberTarget.classList.toggle(this.badClass, !this.number.test(value));
    this.numberTarget.classList.toggle(this.goodClass, this.number.test(value));
    this.lengthTarget.classList.toggle(this.badClass, !this.length.test(value));
    this.lengthTarget.classList.toggle(this.goodClass, this.length.test(value));
    this.matchTarget.classList.toggle(this.badClass, value !== this.confirmTarget.value);
    this.matchTarget.classList.toggle(this.goodClass, value === this.confirmTarget.value);
  }
}

