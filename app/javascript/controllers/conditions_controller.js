import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

// Connects to data-controller="conditions"
export default class extends Controller {
  changeSource(event) {
    const sourceId = event.target.id;
    const id = sourceId.split("_")[3];
    const source = event.target.selectedOptions[0].value;
    console.log("conditions#changeSource", id, source);
    get(`/conditions/fields?id=${id}&source=${source}`, {
      responseKind: "turbo-stream",
    });
  }
}
