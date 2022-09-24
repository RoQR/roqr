import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { productId: Number, email: String, passthrough: String }

  checkout() {
    Paddle.Checkout.open({email: this.emailValue, product: this.productIdValue, passthrough: this.passthroughValue})
  }
}
