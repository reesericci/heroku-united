import { Controller } from "@hotwired/stimulus"
import SignaturePad from "signature_pad"

export default class extends Controller {
  static targets = [ "canvas", "field" ]

  connect() {
    this.pad = new SignaturePad(this.canvasTarget, {
      penColor: window.matchMedia('(prefers-color-scheme: dark)').matches ? "#FBFBFE" : "black"
    });

    this.pad.fromData(this.data)

    this.pad.addEventListener("endStroke", () => {
     this.data = this.pad.toData()
    })

    window.addEventListener("resize", this.resizeCanvas);
    this.resizeCanvas();

    window.matchMedia('(prefers-color-scheme: dark)').addEventListener("change", () => {
      this.updateTheme()
    })
  }

  get data() {
    const data = this.fieldTarget.value ? JSON.parse(this.fieldTarget.value) : []
    
    data.forEach((p) => {
      p.penColor = window.matchMedia('(prefers-color-scheme: dark)').matches ? "#FBFBFE" : "black"
    })

    return data
  }

  set data(content) {
    this.fieldTarget.value = JSON.stringify(content);
  }

  resizeCanvas() {
    const ratio = Math.max(window.devicePixelRatio || 1, 1);
    this.canvasTarget.width = this.canvasTarget.offsetWidth * ratio;
    this.canvasTarget.height = 150 * ratio;
    this.canvasTarget.getContext("2d").scale(ratio, ratio);
    this.pad.clear(); // otherwise isEmpty() might return incorrect value
    this.pad.fromData(this.data);
  }

  undo() {
    let currentData = this.pad.toData();
    if (currentData) {
        currentData.pop(); // remove the last dot or line
        this.pad.fromData(currentData);
    }
  }

  clear() {
    this.pad.clear();
  }

  updateTheme() {
    let currentData = this.pad.toData();
    this.pad.clear()
    currentData.forEach((p) => {
      p.penColor = window.matchMedia('(prefers-color-scheme: dark)').matches ? "#FBFBFE" : "black"
    })
    this.pad.fromData(currentData)
  }
}
