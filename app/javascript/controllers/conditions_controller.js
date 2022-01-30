import { Controller } from "@hotwired/stimulus";
import { get } from "@rails/request.js";

// Connects to data-controller="conditions"
export default class extends Controller {
  changeSource(event) {
    const sourceId = event.target.id;
    const index = sourceId.split("_")[3];
    const source = event.target.selectedOptions[0].value;

    get(`/conditions/fields?index=${index}&source=${source}`, {
      responseKind: "turbo-stream",
    });
  }

  changeField(event) {
    const fieldId = event.target.id;
    const index = fieldId.split("_")[3];
    const source = document.getElementById(
      `alert_conditions_attributes_${index}_source`
    ).selectedOptions[0].value;
    const field = event.target.selectedOptions[0].value;

    get(`/conditions/value?index=${index}&source=${source}&field=${field}`, {
      responseKind: "turbo-stream",
    });
  }
}
