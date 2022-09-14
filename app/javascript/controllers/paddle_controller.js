
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { productId: Number, email: String, passthrough: String }

  connect() {
    Paddle.Environment.set('sandbox');
    Paddle.Setup({ vendor: 7904 });
  }

  checkout() {
    console.log(this.productIdValue)
    Paddle.Checkout.open({email: this.emailValue, product: this.productIdValue, passthrough: this.passthroughValue})
  }
}
