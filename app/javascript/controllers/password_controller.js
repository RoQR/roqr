import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['password', 'confirm', 'uppercase', 'lowercase', 'special', 'number', 'length', 'match'];

  connect() {
    this.uppercase = new RegExp(/[A-Z]/);
    this.lowercase = new RegExp(/[a-z]/);
    this.special = new RegExp(/[^a-z0-9]/i);
    this.number = new RegExp(/[0-9]/);
    this.length = new RegExp(/.{8,}/);
  }

  evaluate() {
    let value = this.passwordTarget.value;
    this.uppercaseTarget.classList.toggle('text-gray-400', !this.uppercase.test(value));
    this.uppercaseTarget.classList.toggle('text-green-200', this.uppercase.test(value));
    this.lowercaseTarget.classList.toggle('text-gray-400', !this.lowercase.test(value));
    this.lowercaseTarget.classList.toggle('text-green-200', this.lowercase.test(value));
    this.specialTarget.classList.toggle('text-gray-400', !this.special.test(value));
    this.specialTarget.classList.toggle('text-green-200', this.special.test(value));
    this.numberTarget.classList.toggle('text-gray-400', !this.number.test(value));
    this.numberTarget.classList.toggle('text-green-200', this.number.test(value));
    this.lengthTarget.classList.toggle('text-gray-400', !this.length.test(value));
    this.lengthTarget.classList.toggle('text-green-200', this.length.test(value));
    this.matchTarget.classList.toggle('text-gray-400', value !== this.confirmTarget.value);
    this.matchTarget.classList.toggle('text-green-200', value === this.confirmTarget.value);
  }
}

