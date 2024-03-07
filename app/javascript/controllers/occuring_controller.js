import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const frame = this.element
    setInterval(function(){
        frame.src = `/votes/results_graph?t=${new Date().getTime()}`
    }, 300000) //ms
  }
}
