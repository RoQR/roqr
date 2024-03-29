// https://github.com/stimulus-components/stimulus-reveal-controller/pull/3/files
import { Controller } from '@hotwired/stimulus'

export default class extends Controller {
  static targets = ['volume', 'price', 'slider']


  updatePrice() {
    let index = this.sliderTarget.value;
    const tiers = [{volume: '10k', price: '9'}, {volume: '100k', price: '19'}, {volume: '200k', price: '29'}, {volume: '500k', price: '49'}, {volume: '1m', price: '69'}, {volume: '2m', price: '89'}, {volume: '5m', price: '129'}, {volume: '10m', price: '169'}];
    let tier = tiers[index]
    this.volumeTarget.textContent = tier['volume']
    this.priceTarget.textContent = tier['price']
  }
}
